module RSokoban
  class RSokobanGame
    # Add these to [@player[:row], @player[:col]] to move the player
    # in the indicated direction.
    DIRECTIONS = {
      left:  [ 0, -1],
      right: [ 0,  1],
      up:    [-1,  0],
      down:  [ 1,  0]
    }
    
    def initialize(window)
      @window = window
    end
    
    def can_move?(direction)
      # Calculate the player's new position if this move is to be executed. Remember that
      # `new_player` is an Array whereas @player is a Hash.
      new_player = [@player[:row], @player[:col]].zip(DIRECTIONS[direction]).map{|a, b| a + b}
      
      if @walls[new_player] then
        return false
      else
        if @boxes[new_player] then
          # Calculate the position of any box that's in the player's way.
          new_box = new_player.zip(DIRECTIONS[direction]).map{|a, b| a + b}
          if @walls[new_box] or @boxes[new_box] then
            return false
          else
            return true
          end
        else
          return true
        end
      end
    end
    
    def draw
      @current_level.walls.keys.each do |k|
        @window.move k[0], k[1]
        @window.addstr '#'
      end
      @goals.keys.each do |k|
        @window.move k[0], k[1]
        @window.addstr '.'
      end
      @boxes.keys.each do |k|
        @window.move k[0], k[1]
        if @goals[k] then
          @window.addstr '+'
        else
          @window.addstr '$'
        end
      end
      @window.move @player[:row], @player[:col]
      @window.addstr '@'
      @window.refresh
    end
    
    def level_complete?
      (@boxes.keys - @goals.keys).empty?
    end
    
    def move(direction)
      return unless can_move?(direction)
      
      new_player = [@player[:row], @player[:col]].zip(DIRECTIONS[direction]).map{|a, b| a + b}
      if @boxes[new_player] then
        new_box = new_player.zip(DIRECTIONS[direction]).map{|a, b| a + b}
        @boxes[new_box]    = true
        @boxes.delete new_player
      end
      
      # Cover up the space behind the player with a space.
      @window.move @player[:row], @player[:col]
      @window.addstr ' '
      
      @player[:row], @player[:col] = new_player
    end
    
    def play_level(level)
      @current_level = level.dup
      
      @walls  = level.walls.dup
      @boxes  = level.boxes.dup
      @player = level.player.dup
      @goals  = level.goals.dup
      
      draw
      
      until level_complete?
        ch = @window.getch
        
        case ch
        when 'q'.ord
          exit
        when 'r'.ord
          @window.clear
          return play_level(level)
        when 'n'.ord
          return
        when Ncurses::KEY_DOWN, 's'.ord
          move :down
        when Ncurses::KEY_UP, 'w'.ord
          move :up
        when Ncurses::KEY_RIGHT, 'd'.ord
          move :right
        when Ncurses::KEY_LEFT, 'a'.ord
          move :left
        end
        
        draw
      end
      
    end
    
  end
end

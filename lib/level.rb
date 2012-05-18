require 'happymapper'

module RSokoban
  attr_accessor :levels
  
  class LevelData
    include HappyMapper
    
    tag 'Level'
    element :id, String
    element :copyright, String
    element :width, Integer
    element :height, Integer
    has_many :lines, String, :tag => 'L'
  end
  
  class Level
    attr_accessor :walls
    attr_accessor :boxes
    attr_accessor :player
    attr_accessor :goals
    
    def initialize(data)
      @walls  = {}
      @boxes  = {}
      @player = {}
      @goals  = {}
      
      data.lines.each_with_index do |line, row|
        line.split(//).each_with_index do |char, col|
          case char
          when '#'
            @walls[[row, col]] = true
          when '$'
            @boxes[[row, col]] = true
          when '.'
            @goals[[row, col]] = true
          when '@'
            @player = {row: row, col: col}
          end
        end
      end
    end
    
    def draw(window)
      @walls.keys.each do |k|
        window.move k[0], k[1]
        window.addstr '#'
      end

      @goals.keys.each do |k|
        window.move k[0], k[1]
        window.addstr '.'
      end
    end
    
    def self.parse(string)
      LevelData.parse(string).map do |level|
        Level.new level
      end
    end
    
    def self.load(filename)
      self.parse(File.open(filename).read)
    end
  end
end


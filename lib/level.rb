module RSokoban
  class Level
    include HappyMapper
    
    element :id, String
    element :copyright, String
    element :width, Integer
    element :height, Integer
    has_many :l, String
    
    def self.load(filename)
      Level.parse(File.open(filename).read).each{|elt| ap elt}
    end
  end
end


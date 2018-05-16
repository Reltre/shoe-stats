require_relative 'parse'
require_relative 'render'

Dir.glob("shoe[1-9]\.txt")
   .map { |file| ShoeParser.new(file).data }
   .each { |shoe_attr| Renderer.new(shoe_attr).render }

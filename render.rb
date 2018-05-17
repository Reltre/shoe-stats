class Renderer
  def initialize(data)
    @filename = data[:@filename]
    @heel_style = data[:@heel_style]
    @toe_style = data[:@toe_style]
    @upper = data[:@upper]
    @sole = data[:@sole]
    @features = data[:@features]
    @heel_height = data[:@heel_height]
  end

  def render
    name
    styles
    material 
    features
    heel_height
  end

  private

  def name
    puts "#{@filename[0..-5]}:"
  end

  def styles
    puts "Heel Style : #{@heel_style}"
    puts "Toe Style : #{@toe_style}"
  end

  def material
    puts "Materials : Uppper: #{@upper}, Sole: #{@sole}"
  end

  def features
    puts "Features : #{@features}" if @features
  end

  def heel_height
    puts "Heel Height : #{@heel_height}\""
    puts
  end
end
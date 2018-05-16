class ShoeParser
  HEEL_STYLES = %w(stiletto block cone)
  TOE_STYLES = %w(peep open)
  MATERIALS = %w(synthetic pu fabric suede manmade)
  FEATURES = %w(lightly\ padded)
  HEEL_HEIGHTS = (1..4)

  def initialize(filename)
    @filename = filename
    post_initialize
  end

  def data
    instance_variables.each_with_object({}) do |ivar, data|
      data[ivar] = instance_variable_get(ivar)
    end
  end

  private

  def post_initialize
    read_file
    populate_styles
    populate_materials
    populate_feature
    populate_heel_height
  end

  def read_file
    @file = File.read(@filename)
  end

  def populate_styles
    populate_heel_style
    populate_toe_style
  end

  def populate_heel_style
    @heel_style = @file.match(/\w+ heel/)[0]
    heel_type = @heel_style.split[0]

    validate("heel_style", heel_type.downcase)
  end

  def populate_toe_style
    @toe_style = @file.match(/\w+ toe/)[0]
    toe_type = @toe_style.split[0]

    validate("toe_style", toe_type.downcase)
  end

  def populate_materials
    @upper = @file.match(/(?<upper>\w+)\s(?=upper)/)[:upper]
    @sole =  @file.match(/(?<sole>\w+)\s(?=sole)/)[:sole]
 
    validate("material", @upper.downcase)
    validate("material", @sole.downcase)
  end

  def populate_feature
    match = @file.match(/(?<feature>\w+\s\w+?)\s(?=footbed)/)
    if match
      match = match[:feature]
      match = match.split.join(' ')
      validate("feature", match.downcase)
    end

    @feature = if match && (match =~ /pad/)
                  "Padding"
                end
  end

  def populate_heel_height
    heel_height = @file.match(/(?<heel_height>(?:\d.)?\d+)"\s(?=heel)/)[:heel_height]
    validate("heel_height", heel_height.to_f)
    @heel_height = heel_height_map(heel_height)
  end

  def validate(resource, shoe_piece)
    white_list = "#{resource}s".upcase.to_sym
    if !ShoeParser.const_get(white_list).include?(shoe_piece)
      raise StandardError, "Not an existing #{resource.downcase}."
    end 
  end

  def heel_height_map(value)
    case value.to_i
    when (1..2)
      "Low Heel"
    when (2..3)
      "Mid Heel"
    when (3..4)
      "High Heel"
    end
  end
end
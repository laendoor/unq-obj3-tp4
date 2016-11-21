require_relative 'open_classes/string'

class Declaration
  def initialize(name, value)
    @name  = name
    @value = value
  end

  def compile
    "#{@name.to_s.hyphen}: #{@value.join(', ')};\n"
  end
end
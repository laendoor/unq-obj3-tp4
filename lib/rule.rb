require_relative 'open_classes/string'

class Rule

  # Una Regla consiste en un nombre y un listado de valores
  def initialize(name, *values)
    @name   = name
    @values = values
  end

  # Se compila como:
  #  regla: valor1 .. valorN
  def compile
    "#{@name.to_s.hyphen}: #{@values.join(' ')};\n"
  end

end
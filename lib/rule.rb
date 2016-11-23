require_relative 'open_classes/array'
require_relative 'open_classes/string'
require_relative 'open_classes/object'

class Rule

  # Una Regla consiste en un nombre y un listado de valores
  def initialize(name, values)
    @name   = name
    @values = values
  end

  # Se compila como:
  #  regla: valor1 .. valorN
  def compile
    "#{@name.to_s.hyphen}: #{@values.map{ |v| v.compile }.join(' ')};\n"
  end

end
require_relative 'helpers/color'
require_relative 'open_classes/string'

class BackgroundRule
  include Color

  # La regla de background procesa el bloque
  # para lograr capturar las sub-reglas y armar
  # el listado de reglas de background
  def initialize(name, args, &declarations)
    @name  = name.to_s + '-'
    @rules = {}
    instance_eval(&declarations) unless declarations.nil?
    @rules = @rules.map { |k, v| Rule.new(@name + k.to_s, v) }
  end


  # Se captura los métodos correspondientes a la declaración
  # de background. Si el método es :width o :height, se lo convierte a :size
  def method_missing(declaration, *values, &block)
    if [:width, :height].include? declaration
      set_size(declaration, values)
    else
      @rules[declaration] = values
    end
  end

  # Sintaxis de las propiedades de
  def compile
    @rules.map { |r| r.compile }.join
  end

  # Las propiedades width y height compilan a
  #   => 'size: width-value height-value'
  #
  # Se genera la propiedad :size con valores por defecto :auto
  #   => 'size: auto auto'
  #
  # Al querer setear alguna de las dos, se sobreescribe el valor correspondiente.
  def set_size(declaration, value)
    @rules[:size] = [:auto, :auto] unless @rules.key? :size

    @rules[:size] = declaration.equal?(:width) ? [value, @rules[:size][1]] : [@rules[:size][0], value]
  end

end
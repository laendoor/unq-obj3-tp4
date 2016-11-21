require_relative 'open_classes/string'

class BackgroundDeclaration

  def initialize(name, *args, &declarations)
    @name  = name
    @declarations = {}
    instance_eval(&declarations) unless declarations.nil?
  end


  # Se captura los métodos correspondientes a la declaración
  # de background. Si el método es :width o :height, se lo convierte a :size
  def method_missing(declaration, *values, &block)
    if [:width, :height].include? declaration
      set_size(declaration, values)
    else
      @declarations[declaration] = values
    end
  end

  # Sintaxis de las propiedades de
  def compile
    name = @name.to_s.hyphen
    str = ''
    @declarations.each do |k, v|
      str << "#{name + '-' + k.to_s.hyphen}: #{v.join(' ')};\n"
    end
    str
  end

  # Las propiedades width y height compilan a
  #   => 'background-size: width-value height-value'
  #
  # Se genera la propiedad :size con valores por defecto :auto
  #   => 'background-size: auto auto'
  #
  # Al querer setear alguna de las dos, se sobreescribe el valor correspondiente.
  def set_size(declaration, value)
    @declarations[:size] = [:auto, :auto] unless @declarations.key? :size

    @declarations[:size] = declaration.equal?(:width) ? [value, @declarations[:size][1]] : [@declarations[:size][0], value]
  end

  def rgb(r, g, b)
    "##{to_hex r}#{to_hex g}#{to_hex b}"
  end

  def to_hex(n)
    n.to_s(16).rjust(2, '0').upcase
  end

end
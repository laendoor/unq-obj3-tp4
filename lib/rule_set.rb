require_relative 'rule'
require_relative 'selector'
require_relative 'background_rule'

class RuleSet
  attr_accessor :selector, :rules

  # Existen nombres de propiedades de css que son métodos de Object.
  # Es necesario "quitarlos" de la clase para poder capturarlos con method_missing
  undef_method :display

  # Un conjunto de reglas contiene un selector (al cual se le aplicarán las reglas)
  # y un conjunto de reglas. Las reglas llegan en forma de bloque
  # selector :param? {
  #   regla1 propiedades
  #   regla2 propiedades
  #   ...
  # }
  def initialize(name, *args, &block)
    self.selector = Selector.new(name, args)
    self.rules = []
    @params = args.first.class.equal?(Hash) ? args.first : {}
    @class_map = { :background => BackgroundRule }
    instance_eval(&block) unless block.nil?
  end

  # Permite capturar el comportamiento de las reglas
  # Una regla puede ser simple o bien contener un subconjunto de reglas
  # Según el caso se inicializa una clase u otra.
  #
  # Una regla puede ser del tipo :with.
  # Eso indica que es necesario reemplazarla por el mixin correspondiente.
  # En ese caso (si es que también existe el mixin) en vez de agregar la regla :with
  # se agregan las reglas del mixin.
  def method_missing(property, *args, &block)
    if is_mixin?(property, args.first)
      self.rules += args.first.rules
    else
      rules << get_rule(property).new(property, values(args), &block)
    end
  end

  def get_rule(property)
    @class_map.has_key?(property) ? @class_map[property] : Rule
  end

  def values(args)
    args.map { |arg| @params.has_key?(arg) ? @params[arg] : arg }
  end

  # Verifica que la propiedad utilice el keyword with
  # y además que lo que recibe sea un conjunto de reglas
  # obtenidas como resultado de la ejecución del método asociado al mixin
  #
  # a {
  #   with noDecoration
  # }
  # mixin :noDecoration {
  #  display: block,
  #  textDecoration: none;
  # }
  def is_mixin?(property, name)
    property.equal?(:with) && name.class.equal?(RuleSet)
  end

  # La compilación del set de reglas se estructura con la compilación
  # del selector, y la compilación de las reglas dentro de llaves {}
  # selector :arg1?, .., :arg2? {
  #   prop1: value1 .. valueN
  #   ..
  # }
  def compile
    str = "#{@selector.compile} {\n"
    rules.each do |d|
      str << "  #{d.compile} \n"
    end
    str << "}\n"
  end

end

require_relative 'selector'
require_relative 'rule'
require_relative 'background_rule'

class RuleSet

  # Un conjunto de reglas contiene un selector (al cual se le aplicarán las reglas)
  # y un conjunto de reglas. Las reglas llegan en forma de bloque
  # selector :param? {
  #   regla1 propiedades
  #   regla2 propiedades
  #   ...
  # }
  def initialize(name, mixins, *args, &block)
    @selector = Selector.new(name, args)
    @mixins = mixins
    @rules = []
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
    if property_has_mixin(property, args.first)
      mixin_rules(args.first).each { |rule| @rules << rule }
    elsif property.equal? :background
      @rules << BackgroundRule.new(property, &block)
    else
      @rules << Rule.new(property, args)
    end
  end

  # Verifica que la propiedad utilice el keyword with y además que exista un mixin asociado al argumento de with
  # a {
  #   with: noDecoration
  # }
  # mixin :noDecoration {
  #  display: block,
  #  textDecoration: none;
  # }
  def property_has_mixin(property, name)
    property.equal?(:with) && @mixins.select{ |m| m.name.equal?(name) }.size > 0
  end


  # Obtiene las reglas del primer mixin que matchee
  # Precondición: existe al menos un mixin que matchea
  def mixin_rules(name)
    @mixins.select { |m| m.name.equal?(name) }.first.rules
  end

  # La compilación del set de reglas se estructura con la compilacion
  # del selector, y la compilación de las reglas dentro de llaves {}
  # selector :arg1?, .., :arg2? {
  #   prop1: value1 .. valueN
  #   ..
  # }
  def compile
    str = "#{@selector.compile} {\n"
    @rules.each do |d|
      str << "  #{d.compile} \n"
    end
    str << "}\n"
  end


end

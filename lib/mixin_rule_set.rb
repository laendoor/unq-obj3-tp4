require_relative 'selector'
require_relative 'rule'
require_relative 'background_rule'

class MixinRuleSet
  attr_accessor :name, :rules

  # Un conjunto de reglas contiene un selector (al cual se le aplicarán las reglas)
  # y un conjunto de reglas. Las reglas llegan en forma de bloque
  # selector :param? {
  #   regla1 propiedades
  #   regla2 propiedades
  #   ...
  # }
  def initialize(name, &block)
    self.name  = name
    self.rules = []
    instance_eval(&block) unless block.nil?
  end

  # Hack: Como display es un método de Object, tengo que capturarlo
  def display(*args)
    rules << Rule.new(:display, args)
  end

  # Permite capturar el comportamiento de las reglas
  # Una regla puede ser simple o bien contener un subconjunto de reglas
  # Según el caso se inicializa una clase u otra
  def method_missing(property, *args, &block)
    if property.equal? :background
      rules << BackgroundRule.new(property, &block)
    else
      rules << Rule.new(property, args)
    end
  end


end

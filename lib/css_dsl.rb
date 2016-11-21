require_relative 'rule_set'
require_relative 'mixin_rule_set'
require_relative 'helpers/color'

class CssDSL
  include Color

  # Una hoja de estilos es un listado de sets de reglas
  def initialize
    @mixins = []
    @rule_sets = []
  end

  # Método que permite la inicialización del DSL
  def stylesheet(&block)
    instance_eval(&block) unless block.nil?
  end

  # Al compilar a css se compila cada set de reglas
  def compile
    @rule_sets.map{ |r| r.compile }.join
  end

  # Cada set de reglas se interpreta como un método, parámetros y un bloque.
  # Se asume que esa construcción es un Set de Reglas:
  # selector :param? {
  #   regla propiedades
  # }
  def method_missing(selector, *args, &block)
    if selector.equal? :mixin
      @mixins << MixinRuleSet.new(args.first, &block)
    else
      @rule_sets << RuleSet.new(selector, @mixins, args, &block) unless selector.equal?(:let)
    end

    self
  end

end

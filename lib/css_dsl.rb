require_relative 'rule_set'

class CssDSL

  def initialize
    @rules = []
  end

  def compile
    @rules.map{ |r| r.compile }.join
  end

  def method_missing(selector, *args, &block)
    @rules << RuleSet.new(selector, args, &block)
    self
  end

  def stylesheet(&block)
    instance_eval(&block) unless block.nil?
  end


end

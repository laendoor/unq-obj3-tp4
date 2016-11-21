require_relative 'rule'

class Css

  def initialize
    @rules = []
  end

  def compiled
    @rules.map{ |r| r.compiled }.join
  end

  def method_missing(selector, *args, &block)
    @rules << Rule.new(selector, args, &block)
    self
  end

  def stylesheet(&block)
    instance_eval(&block) unless block.nil?
  end


end

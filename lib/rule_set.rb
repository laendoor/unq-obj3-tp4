require_relative 'selector'
require_relative 'declaration'
require_relative 'background_declaration'

class RuleSet

  def initialize(selector_name, *args, &block)
    @selector = Selector.new selector_name
    @declarations = []
    instance_eval(&block) unless block.nil?
  end

  def method_missing(property, *args, &block)
    if property.equal? :background
      @declarations << BackgroundDeclaration.new(property, args, &block)
    else
      @declarations << Declaration.new(property, args, &block)
    end
  end

  def compile
    str = "#{@selector.compile} {\n"
    @declarations.each do |d|
      str << "  #{d.compile} \n"
    end
    str << "}\n"
  end


end

require_relative 'selector'
require_relative 'declaration'
require_relative 'background_declaration'

class RuleSet

  def initialize(selector_name, *args, &block)
    @selector = Selector.new selector_name
    @args = args.first
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
    str = "#{@selector.compile} #{args}{\n"
    @declarations.each do |d|
      str << "  #{d.compile} \n"
    end
    str << "}\n"
  end

  def args
    @args.map{ |a| a.to_s.as_arg }.join(' ') << ' ' unless @args.empty?
  end


end

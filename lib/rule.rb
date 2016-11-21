class Rule

  def initialize(selector, *args, &block)
    @selector = selector
    @declarations = {}
    instance_eval(&block) unless block.nil?
  end

  def method_missing(property, *values, &block)
    @declarations[property] = values
  end

  def compiled
    str = "#{parse(@selector)} {\n"
    @declarations.each do |k,v|
      str << "  #{k}: #{v.join(', ')};\n"
    end
    str << "}\n"
  end

  # Parsea los selectores
  #
  # tag    => tag
  # _clase => .clase
  # __id   => #id
  #
  # FIXME seguro se puede hacer algo más lindo
  def parse(selector)
    selector.to_s.gsub(/__/, '#').gsub(/_/, '.')
  end


end

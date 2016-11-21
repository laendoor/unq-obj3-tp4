class Selector

  def initialize(name)
    @name = name
  end

  # Compila los selectores
  #
  # tag    => tag
  # _clase => .clase
  # __id   => #id
  def compile
    @name.to_s.gsub(/__/, '#').gsub(/_/, '.')
  end
end
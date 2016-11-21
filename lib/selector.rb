
# Un selector puede ser un Tag, una Class o un Id.
# A su vez puede tener 0 o más propiedades
class Selector

  def initialize(name, args)
    @name  = name
    @props = args.first
  end

  # Compila el nombre y las propiedades
  def compile
    name + props
  end

  # Selectores
  # tag    => tag
  # _clase => .clase
  # __id   => #id
  def name
    @name.to_s.gsub(/__/, '#').gsub(/_/, '.')
  end

  # Si existen => :prop1 .. :propN
  def props
    @props.empty? ? '' : ' ' + @props.map{ |a| a.to_s.as_selector_prop }.join(' ')
  end
end
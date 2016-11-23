require_relative 'rgb'

module Color
  # Convierto un color de rgb a hex
  def rgb(r, g, b)
    Rgb.new(r, g, b)
  end
end

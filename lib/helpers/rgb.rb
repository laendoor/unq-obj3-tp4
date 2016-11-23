
class Rgb
  attr_accessor :r, :g, :b

  def initialize(r, g, b)
    self.r = r
    self.g = g
    self.b = b
  end

  def +(rgb)
    Rgb.new(r + rgb.r, g + rgb.g, b + rgb.b)
  end

  def -(rgb)
    Rgb.new(r - rgb.r, g - rgb.g, b - rgb.b)
  end

  def compile
    "##{to_hex r}#{to_hex g}#{to_hex b}"
  end

  def to_hex(n)
    n.to_s(16).rjust(2, '0').upcase
  end
end
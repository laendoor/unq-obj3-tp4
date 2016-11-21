module Color
  # Convierto un color de rgb a hex
  def rgb(r, g, b)
    "##{to_hex r}#{to_hex g}#{to_hex b}"
  end

  def to_hex(n)
    n.to_s(16).rjust(2, '0').upcase
  end
end
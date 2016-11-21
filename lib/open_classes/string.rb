class String
  def minify
    self
      .gsub(/\n/, ' ')
      .gsub(/\s{2,}/, ' ')
      .gsub(/\}/, '};')
      .strip
  end
end
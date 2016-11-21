class String
  def minify
    self
      .gsub(/\n/, ' ')
      .gsub(/\s{2,}/, ' ')
      .gsub(/\}/, '};')
      .strip
  end

  def hyphen
    self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1-\2').
      gsub(/([a-z\d])([A-Z])/,'\1-\2').
      downcase
  end
end
class PxNum
  attr_accessor :value

  def initialize(value)
    self.value = value
  end

  def +(px)
    PxNum.new(value + px.value)
  end

  def -(px)
    PxNum.new(value - px.value)
  end

  def compile
    @value.to_s + 'px'
  end
end
require_relative '../helpers/px_num'

class Fixnum
  def px
    PxNum.new self
  end
end

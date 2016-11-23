require_relative '../helpers/px_num'

class Array
  def compile
    self.map { |e| e.compile }
  end
end
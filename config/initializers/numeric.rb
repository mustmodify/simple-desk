class Numeric
  def decimal_precision(digits=2)
    ((self.to_f * (10**digits)).floor).to_f/(10**digits)
  end
end

class NilClass
  def decimal_precision(digits)
    self
  end
end


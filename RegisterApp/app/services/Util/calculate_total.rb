module Util
  class CalculateTotal
    def self.call(hash)
      total = 0.0
      hash.each do |key, value|
        product = Product.find_by(lookupCode: key)
        total = total + (product.price * value)
      end
      return total
    end
  end
end

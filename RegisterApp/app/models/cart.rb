class Cart < ApplicationRecord
  belongs_to :employee
  validates :cart, presence: true

  def getCart
    return eval(self.cart)
  end

  def setCart(cart)
    self.cart = cart.to_s
    self.save
  end

  before_validation do |cart|
    hash = cart.getCart
    cart.total = calculateTotal(hash)
    cart.productCount = calculateProductCount(hash)
  end

  def calculateTotal(hash)
    total = 0.0
    hash.each do |key, value|
      total = total + value
    end
    return total
  end

  def calculateProductCount(hash)
    total = 0
    knownKeys = []
    hash.each do |key, value|
      if !knownKeys.include? key
        knownKeys.append(key)
        total = total + 1
      end
    end
    return total
  end
end

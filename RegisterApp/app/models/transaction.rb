class Transaction < ApplicationRecord
  belongs_to :employee
  validates :trans, presence: true

  def getTrans
    return eval(self.trans)
  end

  def setTrans(trans)
    self.trans = trans.to_s
    self.save
  end

  before_validation do |transaction|
    hash = transaction.getTrans
    transaction.total = calculateTotal(hash)
    transaction.productCount = calculateProductCount(hash)
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

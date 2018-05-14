# A group of people go camping together, and end up buying a lot of stuff for each other.
# We need to write code to figure out how much people owe each other, and the most efficient way to pay each other back.
# Sarah rents a car for the trip - she pays $400 for the car, which is used by Alice, John, Bob and herself.
# Later in the trip, John went out and bought groceries for $100, which was used only by Alice and Bob.
#
# Now, the trip is over and everyone wants to get paid back what they are
# owed - print out the list of transactions that would settle everyone's debts.
class CostShare
  attr_reader :balance
  def initialize
    @balance = {}
  end

  def add_expense(paid_by, amount, paid_for)
    @balance[paid_by] ||= 0
    @balance[paid_by] += amount
    split = amount / paid_for.length
    paid_for.each do |benefited|
      @balance[benefited] ||= 0
      @balance[benefited] += (-1) * split
    end
  end

  def calculate_settlements
    # sarah: { owes: 0, owed: 300 }, alice: { owes: 100, owed: 0}, john: { owes: 100, owed: 0 }, bob: { owes: 100, owed: 0 }
    # sarah: { owes: 0, owed: 300 }, alice: { owes: 150, owed: 0 }, john: { owes: 0, owed: 0 }, bob: { owes: 150, owed: 0 }
    settlements = []
    puts @balance
    @balance.each do |name, amount|
      # if amount is positive the person should be paid, if it's negative they owe
      if amount < 0
        receipient = get_receipient(amount)
        settlements << { from: name, to: receipient, amount: (-1) * amount }
      end
    end
    settlements
  end

  def get_receipient(amount)
    @balance.each do |name, owed_amount|
      if owed_amount >= amount
        @balance[name] -= amount
        return name
      end
    end
  end
end
require 'spec_helper'
require 'cost_share'

describe CostShare do
  describe 'calculating shared expenses' do
    it 'calculates the settlements for the camping trip' do
      subject.add_expense :sarah, 400, [:sarah, :alice, :john, :bob]
      subject.add_expense :john, 100, [:alice, :bob]

      expect(subject.calculate_settlements).to eq [
                                                   { from: :alice, to: :sarah, amount: 150 },
                                                   { from: :bob, to: :sarah, amount: 150 } ]
    end
  end
end
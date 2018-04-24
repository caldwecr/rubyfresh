require 'spec_helper'
require 'queue_of_two_stacks'

describe QueueOfTwoStacks do
  describe '#enqueue' do
    subject(:queue) { QueueOfTwoStacks.new }
    it 'adds an element at the end of the queue' do
      queue.enqueue 'a'
      queue.enqueue 'b'
      queue.enqueue 'c'

      expect(queue.outbound).to eq %w[c b a]
    end
  end

  describe '#dequeue' do
    subject(:queue) { QueueOfTwoStacks.new %i[cat dog mouse] }
    it 'returns the item from the front of the queue' do
      expect(queue.dequeue).to eq :cat
    end
    it 'removes the first item from the queue' do
      queue.dequeue
      expect(queue.outbound).to eq %i[mouse dog]
    end
  end

  describe '#print_first' do
    subject(:queue) { QueueOfTwoStacks.new %i[cat dog mouse] }

    it 'prints to stdout the first item in the queue' do
      expect(queue).to receive(:puts).with(:cat)
      queue.print_first
    end
  end
end

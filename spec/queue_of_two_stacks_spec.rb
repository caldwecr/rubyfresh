require 'spec_helper'
require 'queue_of_two_stacks'

describe QueueOfTwoStacks do
  describe '#enqueue' do
    it 'adds an element at the end of the queue' do
      subject.enqueue 'a'
      subject.enqueue 'b'
      subject.enqueue 'c'

      expect(subject.outbound).to eq %w[c b a]
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

  describe '#read_first' do
    subject(:queue) { QueueOfTwoStacks.new %i[cat dog mouse] }

    it 'is the first item in the queue' do
      expect(queue.read_first).to eq :cat
    end
  end

  describe '.process_input' do
    it 'is an Array of output from the execution of the queries' do
      output = QueueOfTwoStacks.process_input [
        '10',
        '1 42',
        '2',
        '1 14',
        '3',
        '1 28',
        '3',
        '1 60',
        '1 78',
        '2',
        '2'
      ]
      expect(output).to eq %w[14 14]
    end
  end
end

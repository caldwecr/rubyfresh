require 'spec_helper'
require 'sparse_array'

describe SparseArray do
  describe '#append' do
    it 'increments the occurrences count for the value' do
      subject.append('foo')
      expect(subject.store['foo']).to eq 1
      subject.append('foo')
      expect(subject.store['foo']).to eq 2
    end
  end
  describe '#num_occurrences' do
    it 'is the number of times a particular value has been appended to the SparseArray instance' do
      subject.append('bar')
      subject.append('bar')
      expect(subject.num_occurrences('bar')).to eq 2
    end
  end

  describe '.process_input' do
    it 'executes the input and query operations' do
      expect(SparseArray.process_input(%w[4 aba baba aba xzxb 3 aba xzxb ab])).to eq [2, 1, 0]
    end
    it 'works when none of the queries have any occurrences' do
      expect(SparseArray.process_input(%w[2 foo bar 2 baz bot])).to eq [0, 0]
    end
    it 'works when there is only one query' do
      expect(SparseArray.process_input(%w[2 foo bar 1 foo])).to eq [1]
    end
    it 'works when there is only one input string' do
      expect(SparseArray.process_input(%w[1 foo 3 bar foo baz])).to eq [0, 1, 0]
    end
    it 'works for test case 3 by stripping each line' do
      expected = File.readlines('spec/sparse_array_testcase3_expected.txt').map(&:to_i)

      expect(SparseArray.process_input(File.readlines('spec/sparse_array_testcase3_input.txt'))).to eq expected
    end
  end
end

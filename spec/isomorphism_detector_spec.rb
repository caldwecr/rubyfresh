require 'spec_helper'
require 'isomorphism_detector'

describe IsomorphismDetector do
  describe '.isomorphic?' do
    it 'is true when str_a is isomorphic to str_b' do
      expect(IsomorphismDetector.isomorphic?('egg', 'add')).to be true
      expect(IsomorphismDetector.isomorphic?('paper', 'title')).to be true
    end
    it 'is false when the strings are not isomorphic' do
      expect(IsomorphismDetector.isomorphic?('foo', 'bar')).to be false
      expect(IsomorphismDetector.isomorphic?('ab', 'aa')).to be false
    end
  end
end

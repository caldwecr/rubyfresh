require 'spec_helper'
require 'student_grader'

describe StudentGrader do
  describe '.round_grades' do
    it 'does no rounding of grades less than 38' do
      expect(StudentGrader.round_grades([29])).to eq [29]
    end
    context 'when a grade is greater than or equal to 38' do
      it 'rounds up grades that are fewer than 3 less than the next multiple of five' do
        expect(StudentGrader.round_grades([38, 99])).to eq [40, 100]
      end
    end
  end
end

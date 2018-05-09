# A class that rounds student grades, according to the hackerrank question "Grading Students"
class StudentGrader
  def self.round_grades(grades)
    grades.map do |grade|
      if grade < 38
        grade
      else
        modulo = grade % 5
        gap = 5 - modulo
        if gap < 3
          grade + gap
        else
          grade
        end
      end
    end
  end
end

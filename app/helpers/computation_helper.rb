module ComputationHelper

  def summary
    Assignment.reset

    @assignments.each do |assignment|
      Assignment.process(assignment)       
    end
  end

end


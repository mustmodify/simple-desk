module ChartHelper

  def goal
    2850 
  end

  def complete
    (Assignment.total_for('mustmodify').to_f / goal.to_f).decimal_precision(2) * 100
  end

  def remaining
    100 - complete
  end

  def current
    Assignment.total_for('mustmodify')
  end

  def chart_max
    [current, goal].max
  end

  def chart_values
    if current < goal
      [current, goal-current]
    else
      [goal, current-goal]
    end
  end

  def chart_colors
    if current < goal
      ['33FF00', '336600']
    else
      ['33FF00', '00CCFF']
    end
  end

end


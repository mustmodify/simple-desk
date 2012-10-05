class Assignment < ActiveRecord::Base

  def self.reset
    Assignment.all.each{|assignment| assignment.update_attribute(:hours_worked, 0)}
  end

  def self.total_for( provider )
    out = 0
    l=Assignment.find(:all, :conditions => "provider_odesk_id = '#{provider}'")
    l.each do |assignment|
      out += assignment.total
    end

    out
  end

  def self.process( time_entries )
    time_entries.each do |time_entry|
      assignment = Assignment.find_or_create_by_provider_odesk_id_and_client_odesk_id( :provider_odesk_id => time_entry['provider_id'], :client_odesk_id => time_entry['team_name'], :description  => "#{time_entry['provider_id']} @ #{time_entry['team_name']}")
  
      assignment.add_hours( BigDecimal.new(time_entry['hours'].to_s) )
    end
  end


  def add_hours( value )
    self.update_attribute(:hours_worked, self.hours_worked + value ) 
  end

  def rate
    read_attribute(:rate) || 0
  end

  def hours_worked
    read_attribute(:hours_worked) || 0
  end

  def total
    rate * hours_worked
  end
end


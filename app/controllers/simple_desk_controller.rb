class SimpleDeskController < ApplicationController
  before_filter :odesk_required
  
  def index
    start_of_week = Date.today.monday

    @jw = 7.times.map do |i|
      date = start_of_week + i.days

      RubyDesk::TimeReport.find(@odesk_connector,
        :select=>"team_name, sum(hours), worked_on",
        :conditions=>{:worked_on=>date, :provider_id => 'mustmodify'})
    end.flatten
    @jw.each{|entry| entry['provider_id'] = 'mustmodify'}

     

    @mustmodify = 7.times.map do |i|
      date = start_of_week + i.days

      RubyDesk::TimeReport.find(@odesk_connector,
        :select=>"provider_id, team_name, sum(hours), worked_on",
        :conditions=>{:worked_on=>date, :agency_id => 'mustmodify'})
    end.flatten

    Assignment.reset
    Assignment.process(@jw + @mustmodify).uniq

    flash[:notice] = "Reloaded data at #{Time.now}"

    redirect_to assignments_path
  end
  
  def search_jobs
    @jobs = RubyDesk::Job.search(@odesk_connector, params[:query])
  end

  def team_rooms
    @team_rooms = RubyDesk::TeamRoom.get_teamrooms(@odesk_connector)
  end
end

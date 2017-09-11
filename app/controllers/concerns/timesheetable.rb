# making controller skinny by using timesheetable module
module Timesheetable
  extend ActiveSupport::Concern

  def calculate_total_hours_on_a_day(id)
    @total_hours_worked = []
    dates_of_timesheets = [Date.today, Date.yesterday, 2.day.ago.to_date, 3.day.ago.to_date, 4.day.ago.to_date]
    dates_of_timesheets.each do |date|
      @total_hours_worked << Timesheet.get_total_hours_on_a_date(id, date)
    end
  end

  def calculate_hours_on_a_project(employee_id)
    data_for_calculating_hours
    @all_projects.each do |proj|
      project_id = proj[0]
      calculate_hours_for_previous_days(project_id, employee_id)
      calculate_hours_for_yest_and_today(project_id, employee_id)
      total_time_and_percentage_calculator(project_id, employee_id)
    end
  end

  def calculate_hours_for_previous_days(project_id, employee_id)
    @total_hours_4dayb4[project_id] = Timesheet.get_hours_in_project_on_date(employee_id, 4.day.ago.to_date, project_id)
    @total_hours_3dayb4[project_id] = Timesheet.get_hours_in_project_on_date(employee_id, 3.day.ago.to_date, project_id)
    @total_hours_dayb4yes[project_id] = Timesheet.get_hours_in_project_on_date(employee_id, 2.day.ago.to_date, project_id)
  end

  def calculate_hours_for_yest_and_today(project_id, employee_id)
    @total_hours_yest[project_id] = Timesheet.get_hours_in_project_on_date(employee_id, Date.yesterday, project_id)
    @total_hours_today[project_id] = Timesheet.get_hours_in_project_on_date(employee_id, Date.today, project_id)
  end

  def total_time_and_percentage_calculator(project_id, employee_id)
    @total_hours_in_last_5_days_4project[project_id] = Timesheet.get_total_hours_in_last_5_days(project_id, employee_id)
    @percentage[project_id] = (@total_hours_in_last_5_days_4project[project_id] / 40) * 100
  end

  def data_for_calculating_hours
    @total_hours_4dayb4 = {}
    @total_hours_3dayb4 = {}
    @total_hours_dayb4yes = {}
    @total_hours_yest = {}
    @total_hours_today = {}
    @total_hours_in_last_5_days_4project = {}
    @percentage = {}
  end

  def timesheet_values
    @timesheets = Timesheet.employee_timesheet(params[:id].to_s)
    @total_time_spend = Timesheet.get_total_hours_in_all_proj(params[:id])
    calculate_total_hours_on_a_day(params[:id])
    utilization_details
  end

  def utilization_details
    calculate_hours_on_a_project(params[:id])
    @total_hours_worked_for_last_5_days = @total_hours_in_last_5_days_4project.values.inject(:+).to_f
    @total_perc_in_last_5_days_project = (@total_hours_worked_for_last_5_days / 40) * 100
  end
end

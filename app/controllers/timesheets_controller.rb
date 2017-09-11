# controller for timesheet management
class TimesheetsController < ApplicationController
  include Timesheetable
  before_action :find_date_worked, only: %i[create update]
  before_action :check_whether_exceeds_maximum_hours, only: %i[create update], if: :time_spend_exceeded?
  before_action :fetch_all_projects

  def new
    @user = Employee.find(params[:id])
    @projects = Project.all
    @timesheet = Timesheet.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @timesheets = Timesheet.new(timesheet_params)
    if @timesheets.save
      redirect_to action: 'index', id: params[:timesheet][:employee_id], project_id: params[:timesheet][:project_id]
    else
      flash.now[:error] = t(:error)
    end
  end

  def index
    @user = Employee.find(params[:id])
    timesheet_values
    respond_to do |format|
      format.html
    end
  end

  def show
    @timesheet = Timesheet.employee_timesheet(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def edit
    @timesheet = Timesheet.get_timesheet_record(params[:timesheet_id])
    @user = Employee.find(params[:id])
    @projects = Project.all
    @timesheet_count = @timesheet.count
    respond_to do |format|
      format.html
    end
  end

  def update
    @timesheet = Timesheet.find(params[:id])
    if @timesheet.update_attributes(timesheet_params)
      redirect_to action: 'index', id: params[:timesheet][:employee_id], project_id: params[:timesheet][:project_id]
    else
      render action: 'edit'
    end
  end

  private

  def check_whether_exceeds_maximum_hours
    flash[:alert] = t(:error)
    redirect_to new_timesheet_path(id: params[:timesheet][:employee_id])
  end

  def time_spend_exceeded?
    find_date_worked
    @timesheet_per_day = Timesheet.get_total_hours_on_a_date(params[:timesheet][:employee_id], @date_worked)
    timesheet_params[:timespend].to_f + @timesheet_per_day > 8.00
  end

  def find_date_worked
    @date_worked = params[:id].nil? ? params[:timesheet][:date_worked] : Timesheet.get_date_worked_from_timesheet_id(params[:id])
  end

  def timesheet_params
    params.require(:timesheet).permit(:timespend, :project_id, :date_worked, :employee_id, :description)
  end

  def fetch_all_projects
    @all_projects = Project.all.pluck(:id, :project_name)
  end
end

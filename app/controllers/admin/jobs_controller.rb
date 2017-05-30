class Admin::JobsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_job_and_check_permission, only: [:edit, :update]
  before_action :is_admin?

  layout 'admin'

  def index

    @suggests = Job.published.random5

    @locations = Location.newest_first
    @categorys = Category.newest_first

    if params[:location].present?
      @location = params[:location]
      @location_id = Location.find_by(name: @location)

      if @location == 'All Locations'
        @jobs = Job.published.newest_first.paginate(page: params[:page], per_page: 7)
      else
        @jobs = Job.published.where(location: @location_id).newest_first.paginate(page: params[:page], per_page: 7)
      end

    elsif params[:category].present?
      @category = params[:category]
      @category_id = Category.find_by(name: @category)

      if @category == "All Categories"
        @jobs = Job.published.newest_first.paginate(page: params[:page], per_page: 7)
      else
        @jobs = Job.published.where(category: @category_id).newest_first.paginate(page: params[:page], per_page: 7)
      end


    elsif params[:wage].present?
      @wage = params[:wage]
      if @wage == '0~3k'
        @jobs = Job.wage1.published.newest_first.paginate(:page => params[:page], :per_page => 7)
      elsif @wage == '3~5k'
        @jobs = Job.wage2.published.newest_first.paginate(:page => params[:page], :per_page => 7)
      elsif @wage == '5~7k'
        @jobs = Job.wage3.published.newest_first.paginate(:page => params[:page], :per_page => 7)
      elsif @wage == '7~10k'
        @jobs = Job.wage4.published.newest_first.paginate(:page => params[:page], :per_page => 7)
      end

    else

      @jobs = Job.published.newest_first.paginate(:page => params[:page], :per_page => 7)
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
    @categorys = Category.published.newest_first
    @locations = Location.published.newest_first
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    if @job.save
      redirect_to admin_jobs_path , notice: "Add job successfully"
    else
      render :new
    end
  end


  def edit
    @job = Job.find(params[:id])
    @categorys = Category.published.newest_first
    @locations = Location.published.newest_first
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
    redirect_to admin_jobs_path, notice: "Job updated successfully"
    else
    render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
  end


  def publish
    @job = Job.find(params[:id])
    @job.publish!
    redirect_to :back
  end

  def hide
    @job = Job.find(params[:id])
    @job.hide!
    redirect_to :back
  end

private

  def job_params
    params.require(:job).permit(:title, :description, :contact_email, :wage_lower_bound, :wage_upper_bound, :is_hidden, :company, :location_id, :category_id)
  end

  def find_job_and_check_permission
    @job = Job.find(params[:id])

    if @job.user != current_user
      redirect_to root_path, alert: "Sorry, You have no authority"
    end
  end

end

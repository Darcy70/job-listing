class JobsController < ApplicationController

  before_action :authenticate_user!, except:[:index, :show]

  def index
    @jobs = case params[:order]
    when "Lowerbound"
      Job.published.order("wage_lower_bound DESC").paginate(:page => params[:page], :per_page => 7)
    when "Upperbound"
      Job.published.order("wage_upper_bound DESC").paginate(:page => params[:page], :per_page => 7)
    else
      Job.published.newest_first.paginate(:page => params[:page], :per_page => 7)
    end
  end

  def show
    @job = Job.find(params[:id])

    if @job.is_hidden
      flash[:notice] = "This job has already been archieved"
      redirect_to jobs_path
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to(jobs_path)
    else
      render('new')
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(job_params)
      redirect_to(jobs_path)
    else
      render('edit')
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
  end


  private

  def job_params
    params.require(:job).permit(:title, :description, :contact_email, :wage_lower_bound, :wage_upper_bound, :is_hidden)
  end


end

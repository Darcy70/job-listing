class JobsController < ApplicationController

  before_action :authenticate_user!, except:[:index, :show]

  def index
    @jobs = Job.where(is_hidden: false).newest_first
  end

  def show
    @job = Job.find(params[:id])
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

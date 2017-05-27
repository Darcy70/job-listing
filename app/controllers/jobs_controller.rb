class JobsController < ApplicationController

  before_action :authenticate_user!, except:[:index, :show]

  def index
    @jobs = Job.published.newest_first.paginate(:page => params[:page], :per_page => 7)
    @suggests = Job.published.random5

  end

  def show
    @job = Job.find(params[:id])

    @category = @job.category
    @sames = Job.where(:is_hidden => false, :category => @job.category).where.not(id: @job.id).random5
    @resumes = Resume.where(job: @job, user: current_user )
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

  def add
    @job = Job.find(params[:id])
    @job.user_id = current_user.id
    if !current_user.is_member_of?(@job)
      current_user.add_collection!(@job)
    end
    redirect_to :back
  end

  def remove
    @job = Job.find(params[:id])
    if current_user.is_member_of?(@job)
      current_user.remove_collection!(@job)
    end
    redirect_to :back
  end


  private

  def job_params
    params.require(:job).permit(:title, :description, :contact_email, :wage_lower_bound, :wage_upper_bound, :is_hidden)
  end


end

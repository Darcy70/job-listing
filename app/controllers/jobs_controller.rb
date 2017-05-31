class JobsController < ApplicationController

  before_action :authenticate_user!, only:[:add, :remove]
  before_action :validate_search_key, only: [:search]

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

    @category = @job.category
    @sames = Job.where(:is_hidden => false, :category => @job.category).where.not(id: @job.id).random5
    @resumes = Resume.where(job: @job, user: current_user )
    if @job.is_hidden
      flash[:notice] = "This job has already been archieved"
      redirect_to jobs_path
    end
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

  def search
    if @query_string.present?
      search_result = Job.joins(:location).ransack(@search_criteria).result(distinct: true)
      @jobs = search_result.published.paginate(page: params[:page], per_page: 7)
      @suggests = Job.published.random5
    end
  end


protected

  def validate_search_key
    @query_string = params[:keyword].gsub(/\\|\'|\/|\?/, "") if params[:keyword].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { :title_or_company_or_location_name_cont => query_string}
  end


end

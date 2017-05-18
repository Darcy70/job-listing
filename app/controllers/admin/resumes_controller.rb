class Admin::ResumesController < ApplicationController

  before_action :authenticate_user!
  before_action :is_admin?
  layout 'admin'

  def index
    @job = Job.find(params[:id])
    @resumes = @job.resumes.newest_first
  end


end

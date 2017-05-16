module Admin::JobsHelper

  def render_job_status(job)
    if job.is_hidden
      "(Hidden)"
    else
      "(Pubulic)"
    end
  end


end

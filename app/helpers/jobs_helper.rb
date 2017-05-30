module JobsHelper

  # Icon status
  def render_job_status(job)
    if job.is_hidden
      "fa fa-lock"
    else
      "fa fa-globe"
    end
  end

  # Wage status
  def render_job_wage(job)
    "#{job.wage_lower_bound} ~ #{job.wage_upper_bound} "
  end

  # Resume status
  def render_job_resumes(job)
    if job.resumes.count > 0
      "fa fa-envelope-open-o"
    else
      "fa fa-envelope-o"
    end
  end

  # Collection Status
  def render_job_collections(job)
    if job.collections.count > 0
      "fa fa-heart"
    else
      "fa fa-heart-o"
    end
  end

  # Hidden Status
  def render_job_hidden(job)
    if job.is_hidden
      "hidden-box"
    end
  end

end

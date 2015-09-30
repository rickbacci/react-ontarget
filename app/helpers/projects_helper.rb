module ProjectsHelper

  def statuses
    ['backlog', 'ready', 'in-progress', 'completed']
  end

  def added_to_projects(project_name)
    current_user.projects.pluck(:name).include?(project_name)
  end

  def has_label?(labels, name)
    labels.any?{ |label| label.name == name}
  end

  def different_repo(issue, current_user)
    issue.repository.name != current_user.current_project
  end

  def different_column(issue, status)
    issue.labels.none? { |label| label.name == status }
  end

  def different?(issue, status, current_user)
    different_repo(issue, current_user) || different_column(issue, status)
  end

  def get_time(labels)
    labels = labels.map { |label| label.name }

    return 1500000 if labels.include?('1500000')
    return 3000000 if labels.include?('3000000')
    5000
  end

  def set_time(time, value)
    return true if time == value
    false
  end

  def convert_time(milliseconds)
    case milliseconds
    when 5000
      "5 Seconds"
    when 1500000
      "25 Minutes"
    when 3000000
      "50 Minutes"
    end
  end
end
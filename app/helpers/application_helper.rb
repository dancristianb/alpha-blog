module ApplicationHelper
  def alert_type(name)
    name == 'alert' ? 'alert-danger' : 'alert-success'
  end
end

module ApplicationHelper

  # If an event's start and end date are the same, just show start date.
  # Otherwise, display as started_on to ended_on.
  def smart_dates(event)
    if event.started_on == event.ended_on
      event.started_on
    else
      "#{event.started_on} to #{event.ended_on}"
    end
  end

end

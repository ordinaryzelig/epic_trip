class Event < ActiveRecord::Base

  belongs_to :calendar

  before_validation :assign_ended_on

  validates :calendar_id, presence: true
  validates :calendar, associated: true
  validates :started_on, presence: true
  validates :ended_on, presence: true, on_or_after_started_on: true

  scope :after, proc { |date| where('started_on > ?', date) }

  # Positive days to start time in future,
  # negative days to ended_on in past,
  # 0 days if in progress.
  def distance_from_now
    @distance ||= case
    when self.started_on.future?
      self.started_on - Date.current
    when self.ended_on.past?
      self.ended_on - Date.current
    else
      0
    end.to_i
  end

  def human_distance_from_now
    absolute_pluralized = "#{distance_from_now.abs} day"
    absolute_pluralized += 's' if distance_from_now.abs > 1
    case 0 <=> distance_from_now
    when 1
      "#{absolute_pluralized} ago"
    when -1
      "In #{absolute_pluralized}"
    else
      'Now'
    end
  end

  # Days from end of this event to start of given event.
  # Only useful when given event is in future.
  def days_to_event(event)
    (event.started_on - self.ended_on).to_i
  end

  # Accept string which will be parsed.
  def started_on=(obj)
    return super unless obj.is_a?(String)
    super parse_date_string(obj)
  end

  # Accept string which will be parsed.
  def ended_on=(obj)
    return super unless obj.is_a?(String)
    super parse_date_string(obj)
  end

  private

  def assign_ended_on
    self.ended_on ||= self.started_on
  end

  def parse_date_string(date_string)
    Chronic.parse(date_string).to_date unless date_string.blank?
  end

end

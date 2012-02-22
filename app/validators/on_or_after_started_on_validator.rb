class OnOrAfterStartedOnValidator < ActiveModel::EachValidator

  def validate(record)
    return unless record.started_on && record.ended_on
    record.errors.add(:ended_on, "can't be before Start date") if record.ended_on < record.started_on
  end

end

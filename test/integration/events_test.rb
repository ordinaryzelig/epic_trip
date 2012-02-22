require 'test_helper'

describe 'Events integration' do

  it 'events are created by sumitting form' do
    calendar = FactoryGirl.create(:calendar)
    visit new_calendar_event_path(calendar)
    xmas = FactoryGirl.build(:xmas)
    fill_out_event_form(xmas)
    event = Event.first
    event.wont_be_nil
    current_path.must_equal calendar_events_path(calendar)
    page.must_have_content event.name
  end

  it 'event lists later events' do
    calendar = FactoryGirl.create(:holiday_season)
    xmas, new_years = calendar.events
    visit calendar_event_path(calendar, xmas)
    page.must_have_content new_years.name
  end

end

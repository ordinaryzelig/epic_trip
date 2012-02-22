require 'test_helper'

describe 'Calendars integration' do

  it 'calendars are created by submitting form' do
    visit new_calendar_path
    click_button 'Save'
    calendar = Calendar.first
    current_path.must_equal calendar_path(calendar)
  end

  describe 'calendar' do

    let(:calendar) { FactoryGirl.create(:holiday_season) }

    before do
      visit calendar_events_path(calendar)
    end

    it 'lists events chronologically' do
      calendar.events.each do |event|
        page.must_have_content event.name
      end
    end

    it 'displays time between events' do
      xmas, new_years = calendar.events.all
      within "#distance_between_events_#{xmas.id}_#{new_years.id}" do
        page.must_have_content '7 days'
      end
    end

  end

end

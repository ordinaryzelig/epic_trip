require 'test_helper'

describe Event do

  it 'sets ended_on to started_on if left blank' do
    xmas = FactoryGirl.build(:xmas, ended_on: nil)
    xmas.valid?
    xmas.ended_on.must_equal xmas.started_on
  end

  it '#days_to_event returns number of days from end of this to start of given event' do
    xmas = FactoryGirl.build(:xmas)
    new_years = FactoryGirl.build(:new_years)
    xmas.days_to_event(new_years).must_equal 7
  end

  describe '#distance_from_now' do

    it 'returns positive days until started_on if event is in future' do
      event = Event.new(started_on: Date.tomorrow)
      event.distance_from_now.must_equal 1
    end

    it 'returns negative days until started_on if event is in past' do
      event = Event.new(started_on: 1.week.ago.to_date, ended_on: Date.yesterday)
      event.distance_from_now.must_equal -1
    end

    it 'returns 0 if in progress' do
      event = Event.new(started_on: Date.today, ended_on: Date.current)
      event.distance_from_now.must_equal 0
    end

  end

  it '#started_on= accepts and parses strings for setting started_on' do
    event = Event.new(started_on: 'today')
    event.started_on.must_equal Date.today
  end

  it '#ended_on= accepts and parses strings for setting ended_on' do
    event = Event.new(ended_on: 'today')
    event.ended_on.must_equal Date.today
  end

  describe 'ended_on' do
    it 'must not be before started_on' do
      event = Event.new(started_on: Date.today, ended_on: Date.today - 1)
      event.valid?
      event.errors[:ended_on].wont_be_nil
    end
  end

  describe 'human_distance_from_now' do

    it 'returns how many days in the future the event will start' do
      event = Event.new(started_on: Date.tomorrow, ended_on: Date.tomorrow)
      event.human_distance_from_now.must_equal 'In 1 day'
      event = Event.new(started_on: Date.current + 2)
      event.human_distance_from_now.must_equal 'In 2 days'
    end

    it 'returns how many days in the past the event ended' do
      event = Event.new(started_on: Date.yesterday, ended_on: Date.yesterday)
      event.human_distance_from_now.must_equal '1 day ago'
      event = Event.new(started_on: Date.current - 2, ended_on: Date.current - 2)
      event.human_distance_from_now.must_equal '2 days ago'
    end

    it 'returns "Now" if event is currently happening' do
      event = Event.new(started_on: Date.current, ended_on: Date.current)
      event.human_distance_from_now.must_equal 'Now'
    end

  end

end

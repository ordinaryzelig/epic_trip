class EventsController < ApplicationController

  expose(:calendar) { Calendar.find_by_id!(params[:calendar_id]) }
  expose(:events)   { calendar.events }
  expose(:event)    { calendar.events.find(params[:id]) }

  def index
  end

  def show
  end

  def new
    @event = events.new
  end

  def edit
  end

  def create
    @event = events.new(params[:event])
    if @event.save
      redirect_to calendar_events_path, notice: 'Event was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @event = event
    if @event.update_attributes(params[:event])
      redirect_to calendar_events_path, notice: 'Event was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @event = event
    @event.destroy
    redirect_to calendar_events_path
  end

end

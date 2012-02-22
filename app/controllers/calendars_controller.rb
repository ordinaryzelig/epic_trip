class CalendarsController < ApplicationController

  def index
    @calendars = Calendar.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calendars }
    end
  end

  def show
    @calendar = Calendar.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calendar }
    end
  end

  def new
    @calendar = Calendar.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calendar }
    end
  end

  #def edit
    #@calendar = Calendar.find(params[:id])
  #end

  def create
    @calendar = Calendar.new(params[:calendar])
    respond_to do |format|
      if @calendar.save
        format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
        format.json { render json: @calendar, status: :created, location: @calendar }
      else
        format.html { render action: "new" }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  #def update
    #@calendar = Calendar.find(params[:id])
    #respond_to do |format|
      #if @calendar.update_attributes(params[:calendar])
        #format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        #format.json { head :no_content }
      #else
        #format.html { render action: "edit" }
        #format.json { render json: @calendar.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  #def destroy
    #@calendar = Calendar.find(params[:id])
    #@calendar.destroy
    #respond_to do |format|
      #format.html { redirect_to calendars_url }
      #format.json { head :no_content }
    #end
  #end

end

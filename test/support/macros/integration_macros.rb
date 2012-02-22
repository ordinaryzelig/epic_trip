module IntegrationMacros

  def fill_out_event_form(event, options = {})
    submit = options.delete(:submit) { true }
    within "form.event" do
      fill_in 'event_started_on', with: event.started_on.to_s
      fill_in 'event_ended_on', with: event.ended_on.to_s
      fill_in 'event_name', with: event.name
      fill_in 'event_notes', with: event.notes
      find(:xpath, './/input[@name="commit"]').click
    end
  end

  def saop
    save_and_open_page
  end

end

class EventsController < ApplicationController
  expose(:event) do
    if params[:id]
      current_user.events.find(params[:id])
    else
      Event.new
    end
  end

  expose(:events) { current_user.events }

  def index
    render json: events
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    self.event = current_user.events.new(event_params)

    event.recurring_event! if event.save
  end

  def update
    old_event = event

    if event.update(event_params)
      event.update_dependent_future_events(old_event) if params[:update_future_events]
    end
  end

  def destroy
    event.destroy
  end

  private

  def event_params
    params.require(:event).permit(
      :title,
      :public,
      :duration,
      :description,
      :periodicity,
      :start,
      :finish
    )
  end
end

class EventsController < ApplicationController
  expose :events, from: :current_user
  expose :event
  expose(:user) { current_user }

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
    self.event = events.new(event_params)

    CreateRecurringEvents.call(event: event) if event.save
  end

  def update
    old_event = Event.find(params[:id])

    if event.update(event_params)
      return unless params[:update_future_events]

      UpdateRecurringEvents.call(old_event: old_event, event: event)
    end
  end

  def destroy
    event.destroy

    render :destroy
  end

  private

  def event_params
    params.require(:event).permit(
      :title,
      :social,
      :duration,
      :description,
      :periodicity,
      :start,
      :finish
    )
  end
end

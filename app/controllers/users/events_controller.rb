module Users
  class EventsController < ApplicationController
    expose :user, id: :user_id
    expose(:events) { user.events.public_events }
    expose :event

    def index
      render json: events
    end

    def show
    end
  end
end

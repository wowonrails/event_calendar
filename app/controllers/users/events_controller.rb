module Users
  class EventsController < ApplicationController
    expose(:user) { User.find(params[:user_id]) }

    expose(:event) do
      user.events.find(params[:id])
    end

    expose(:events) { user.events.public_events }

    def index
      render json: events
    end

    def show
    end
  end
end

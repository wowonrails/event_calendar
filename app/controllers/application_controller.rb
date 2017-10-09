class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include BulletHelper

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  responders :flash
  respond_to :html
end

class ApplicationController < ActionController::Base
  include SessionHelper
  include GuardHelper

  helper_method :signed_in?, :current_user
end

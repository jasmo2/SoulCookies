class CookieTrackerController < ApplicationController
  def index
  end

  def search
    cookies_params
  end

  def steps
  end
  private
  def cookies_params
    params.permit(params["cookie-number"])
  end
end

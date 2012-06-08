class HomeController < ApplicationController
  skip_before_filter :require_login

  caches_action :welcome

  def welcome
  end
end

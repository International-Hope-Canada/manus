class HomeController < ApplicationController
  skip_before_action :authorize_user!, only: :index
end

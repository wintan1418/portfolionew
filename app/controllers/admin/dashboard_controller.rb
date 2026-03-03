module Admin
  class DashboardController < BaseController
    def index
      @profile = Profile.instance
    end
  end
end

class MissionsController < ApplicationController
  def index
    def index
      @missions = Mission.all
  
      render json: @missions
    end
  end
end

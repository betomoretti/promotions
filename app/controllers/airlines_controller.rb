class AirlinesController < ApplicationController

  # GET /airlines
  # GET /airlines.json
  def index
    @airlines = Airline.all
  end
end

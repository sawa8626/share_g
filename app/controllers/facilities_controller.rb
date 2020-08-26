class FacilitiesController < ApplicationController
  def index
  end

  def new
    @facility = Facility.new
  end
end

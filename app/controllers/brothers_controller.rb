class BrothersController < ApplicationController
  def show
    @brother = Brother.find(params[:id])
  end
end

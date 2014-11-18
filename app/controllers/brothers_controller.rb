class BrothersController < ApplicationController
  def show
    @brother = Brother.find(params[:id])
    @logs = @brother.shortlogs.map { |x| x.to_summary_entry }
  end
end

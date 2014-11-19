class BrothersController < ApplicationController
  def show
    @brother = Brother.find(params[:id])
    @logs = @brother.shortlogs.order('created_at DESC').map { |x| x.to_summary_entry }
  end
end

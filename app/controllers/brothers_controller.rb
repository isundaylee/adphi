class BrothersController < ApplicationController
  load_and_authorize_resource

  def show
    @logs = @brother.shortlogs.order('created_at DESC').map { |x| x.to_summary_entry }.compact
  end

  def index
    @brothers = Brother.current
    @balances = Balance.all.group_by { |x| x.brother_id }.hmap do |b, bs|
      [
        b,
        {
          kitchen: bs.select { |x| x.kitchen? } [0] || Brother.find(b).balance(:kitchen),
          house: bs.select { |x| x.house? } [0] || Brother.find(b).balance(:house),
          social: bs.select { |x| x.social? } [0] || Brother.find(b).balance(:social)
        }
      ]
    end
  end
end

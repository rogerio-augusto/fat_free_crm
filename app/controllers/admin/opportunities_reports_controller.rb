class Admin::OpportunitiesReportsController < ApplicationController
  before_filter :require_user
  
  def stages_snapshot
    @stages = Opportunity.stages_snapshot
  end
end

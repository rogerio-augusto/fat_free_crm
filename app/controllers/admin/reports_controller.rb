class Admin::ReportsController < Admin::ApplicationController
  before_filter "set_current_tab('admin/reports')"
  
  def index
    
  end
  
  def snapshot_by_stages
    @stages = Opportunity.stages_snapshot
  end

end

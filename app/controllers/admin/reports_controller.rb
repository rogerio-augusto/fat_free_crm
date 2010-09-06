class Admin::ReportsController < Admin::ApplicationController
  before_filter "set_current_tab('admin/reports')"
  
  def index
    
  end
  
  def snapshot_by_stages
    @stages = Opportunity.stages_snapshot
  end
  
  def snapshot_by_assignment
    @users = User.all.reject{|u| u.assigned_opportunities.count < 1}
    @series = @users.collect(&:opportunity_report)
  end

end

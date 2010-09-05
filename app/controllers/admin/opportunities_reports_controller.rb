class Admin::OpportunitiesReportsController < ApplicationController
  before_filter :require_user
  
  def index
    @graph = open_flash_chart_object(600,300,"/admin/opportunities_reports/graph_code")
  end

  def graph_code
    report_data = Opportunity.stages_snapshot
    
    bar = Bar.new
    bar.set_values(report_data.collect(&:total))
    
    x_axis = XAxis.new
    x_axis.labels = report_data.collect(&:stage)
    
    chart = OpenFlashChart.new
    chart.set_title(Title.new "Oportunidades por status")
    chart.x_axis = x_axis
    chart.add_element(bar)
    
    render :text => chart.to_s
  end
end

class Admin::ReportsController < Admin::ApplicationController
  before_filter "set_current_tab('admin/reports')"
  
  def index
    
  end
  
  def snapshot_by_stages
    stages = Opportunity.stages_snapshot
    
    @stages_report = HighChart.new('graph') do |f|
      f.chart({:defaultSeriesType => "column"})
      f.plotOptions({:borderColor => "#FFFFFF", :borderRadius => 0, :borderWidth => 1})
      f.legend({:enabled => false})
      f.options[:title][:text] = 'Modalidades por estágio'
      f.y_axis({:title => {:text => 'Total'}})
      f.x_axis(:categories => stages.collect(&:stage), 
               :labels => {
                 :rotation => 0,
                 :align => 'right',
                 :style => {:font => 'normal 13px Verdana, sans-serif'}
                })
                
      f.tooltip({:enabled => false})
      
      f.series(:name => 'Stage', 
               :data => stages.collect(&:total), 
               :dataLabels => {
                 :enabled => true,
                 :rotation => 0,
                 :color => '#FFFFFF',
                 :align => 'right',
                 :x => -5,
                 :y => 15,
                 :style => {:font => 'normal 13px Verdana, sans-serif'}
                })
    end
  end
  
  def snapshot_by_assignment
    @users = User.all.reject{|u| u.assigned_opportunities.count < 1}
    @series = @users.collect(&:opportunity_report)
  end

end

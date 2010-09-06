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
    
    @bar = HighChart.new('column') do |f|
      f.chart({:defaultSeriesType => "bar"})
      f.title({:text=>"Estágios de oportunidade por pessoa"})
      f.legend({:reversed => true})
      f.plot_options({:series=>{:stacking=>"normal"}})
      f.x_axis(:categories => @users.collect(&:first_name))
      f.y_axis({:title => {:text => 'Legenda'}})
      
      # Obtenho todos os estágios diferentes entre os usuários
      stages = @users.inject([]){|stages, user| stages += user.opportunity_report.collect(&:stage)}.uniq
      
      # Adiciono o total de oportunidades no estágio X por usuário, ou 0 se o usuário não possui nenhuma oportunidade neste estágio.
      # Deve gerar a seguinte matriz:
      #  f.series(:name => 'won', :data => [0,3,5,2])
      # Onde cada posição em :data corresponde ao total de oportunidades do usuário naquela posição
      stages.each do |stage|
        data = []
        @users.each do |user|
          user_data = user.opportunity_report.collect{|r| r.total if r.stage == stage}
          user_data.compact.blank? ? data << 0 : data += user_data.compact
        end
        f.series(:name => stage, :data => data)
      end
    end
  end

end

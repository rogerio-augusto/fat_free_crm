module Admin::ReportsHelper
  def render_snapshot_by_stages(stages)
    Seer::visualize(stages, 
                    :as => :column_chart, 
                    :in_element =>'chart', 
                    :series => {
                      :series_label => :stage, 
                      :data_method => :total
                    },
                    :chart_options => {
                      :height => 300,
                      :width => 100 * stages.size,
                      :is_3_d => true,
                      :legend => 'none',
                      :colors => "[{color:'#990000', darker:'#660000'}]",
                      :title => "Opportunities status"
                      #                       :title_x => 'Status',
                      #                       :title_y => 'Quantidade'
                    }
                  )
  end
  
  def render_snapshot_by_assignment
    Seer::visualize(@users, 
          :as => :area_chart,
          :in_element => 'chart',
          :series => {
            :series_label => :first_name,
            :data_label => :stage,
            :data_method => :total,
            :data_series => @series
          },
          :chart_options => { 
            :height => 300,
            :width => 600,
            :axis_font_size => 11,
            :colors => ['#7e7587','#990000','#009900','#005590'],
            :title => "Widget Quantities",
            :point_size => 5
          }
         )
  end
end

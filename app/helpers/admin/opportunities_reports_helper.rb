module Admin::OpportunitiesReportsHelper
  def render_graphic(stages)
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
end

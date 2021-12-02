# server file of shiny app
# connects inputs and outputs of ui
# calls each graphs functions to collect data and plot graph

server = function(input, output, session) {
    file_path = "../data/new_master.csv"
    data = read.csv(file_path)  # read csv file
    
    options(shiny.maxRequestSize = 50*1024^2)
    
    # close shiny app session when user exists browser
    session$onSessionEnded(function() {
        stopApp()
    })
    
    bubble_data = reactive({
        source('./bubble_plot.R')
        output$decade_text = renderText(input$decade)
        data = get_bubble_data(data, input$decade)
        data
    })
    
    output$bubble = renderPlotly({
        source('./bubble_plot.R')
        plot = get_bubble_plot(bubble_data())
        plot
    })
    
    timeline_data = reactive({
        source('./timeline.R')
        data = get_timeline_data(data, input$byRegion, input$years)
        data
    })
    
    output$timeline = renderPlotly({
        source('./timeline.R')
        plot = get_timeline_plot(timeline_data(), input$byRegion)
        plot
    })
    
    streamgraph_data = reactive({
        source('./streamgraph.R')
        data = get_streamgraph_data(data, input$byRegion, input$years)
        data
    })
    
    output$streamgraph = renderPlotly({
        source('./streamgraph.R')
        plot = get_streamgraph_plot(streamgraph_data(), input$byRegion)
        plot
    })
    
    heatmap_data = reactive({
        source('./heat_map.R')
        data = get_heatmap_data(data)
        data
    })

    output$heatmap = renderPlotly({
        source('./heat_map.R')
        plot = get_heatmap_plot(heatmap_data())
        plot
    })

} # end server


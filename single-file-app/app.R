# load packages ----
library(shiny)
library(palmerpenguins)
library(tidyverse)
library(DT)

#user interface ----
ui <- fluidPage( #function from shiny package -= establishes window that user interface elements will live in

    # app title ----
    tags$h1("My App Title"), #need comma!
    
    # app subtitle ----
    tags$h4(tags$strong("Exploring Antarctic Penguin Data")), #tags$strong calls for a bold header
    #h4(strong("Exploring antarctic Penguin Data")) # fopr most common tags, like this one, don't need tags
  
    # body mass slider input ----
    sliderInput(inputId= "body_mass_input", 
                label="Select a range of body masses (g)",
                min= 2700, max=6300, #got range from range(penguins$body_mass_g, na.rm = TRUE)
                value = c(3000,4000)), # starting values for slider
  
    # body mass plot output----
    plotOutput(outputId = "body_mass_scatterplot_output"), #placeholder where plot is intended to live. whave to go into the server to create the plot
    

    # reactive table input ----
    checkboxGroupInput(inputId= "year_input",
      label= "Select year(s)",
      choices=c(2007,2008,2009), #OR subsititue 2007,2008,2009 with  unique(penguins$year)
    selected=c(2007,2008)
       ),
    
    #reactive table output----
    DT::dataTableOutput(outputId = "penguin_DT_output")
    
)

#server ---
server <-  function(input, output) {#server exists as a function - always has input and output

  # filter body masses ----
  body_mass_df <- reactive ({ # have to make a reactive dataframe
    penguins %>%
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2])) #[1] calls first slider , [2] calls second slider. calling the input that we named earlier
  })
  
  
  # render penguin scatter plot----
  output$body_mass_scatterplot_output <- renderPlot({  #telling the ouput which input to connect to and where to put the app
  
    #code to generate our plot
    ggplot(na.omit(body_mass_df()), #need to include parenthenesis after EVERY reactive dataframe
           aes(x = flipper_length_mm, y = bill_length_mm, 
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
           color = "Penguin species", shape = "Penguin species") +
      guides(color = guide_legend(position = "inside"),
             size = guide_legend(position = "inside")) +
      theme_minimal() +
      theme(legend.position.inside = c(0.85, 0.2), 
            legend.background = element_rect(color = "white"))
    
  }) 
  
  #render the
  
  # filter by years for data table ----
  years_df <- reactive ({ # have to make a reactive dataframe
    penguins %>%
      filter(year %in% c(input$year_input)) #
  })
  
  
  ##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ##                                                                            --
  ##------------------------- BUILD REACTIVE DATA TABLE---------------------------
  ##                                                                            --
  ##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  
  # render reactive table ----
  output$penguin_DT_output <- DT::renderDataTable({
    DT::datatable(years_df(),
                  options = list(pagelength = 10), #specifying how many entries youll see on one page
                  rownames = FALSE) #getting rid of object id numbers
    
    
  })
          
  
  }
#combine ui and server into an app ----
shinyApp(ui = ui, server=server)
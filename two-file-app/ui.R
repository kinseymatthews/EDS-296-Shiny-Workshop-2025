# user interface ----
ui<- navbarPage(
  
  title = "LTR Animal Data Explorer",
  
  # (Page 1) intro tabPanel ----
  tabPanel(title="About this App",
           
           "background info will go here"
           
  ), #END page 1 intro tabpanel
  
  # (Page 2) data vis tab panel ----
  tabPanel(title = "Explore the Data",
           
           #tabsetPanel to contain tabs for data viz ----
           tabsetPanel(
             
             # Trout tab panel----
             tabPanel(title="Trout",
                      
                      # trout sidebar layout ----
                      sidebarLayout(
                        
                        # trout sidebar panel ----
                        sidebarPanel(
                          
                          # channel type picker input ----
                          pickerInput(inputId = "channel_type_input",
                                      label = "Select channel type(s):",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade","pool"),
                                      multiple=TRUE,
                                      options=pickerOptions(actionsBox=TRUE)), 
                          
                          # section checkbox group button input ----
                          checkboxGroupButtons(inputId= "section_input",
                                               label= "Select sampling section(s):",
                                               choices=c("Clear Cut"="clear cut forest",
                                                         "Old Growth"=  "old growth forest"),
                                               selected=c("clear cut forest", "old growth forest"),
                                               justified=TRUE ,
                                               checkIcon=list(
                                                 yes = icon("check"), #references icon from awesome library and will show uip
                                                 no=icon("xmark") #references icon from awesome library and will show up
                                               ))#makes the boxes span the whole width
                          
                          
                        ), #End trout sidepar panel
                        
                        #trout main panel
                        mainPanel(
                          
                          #trout scatterplot output ----
                          plotOutput(outputId="trout_scatterplot_output")
                          
                          
                        ) #end trout main panel 
                        
                      ) #END trout sidebar layout
                      
             ), # END trout tab panel
             
             #Penguin tab panel ----
             tabPanel(title="Penguin",
                      
                      # penguin sidebar layout ----
                      sidebarLayout(
                        
                        # penguin sidebar panel ----
                        sidebarPanel(
                          
                          # island type picker here
                          pickerInput(inputId="Island_type_input",
                                      label="Select an island(s)",
                                      choices=unique(penguins$island),
                                      selected=c("Dream","Biscoe"),
                                      multiple=TRUE,
                                      options=pickerOptions(actionsBox=TRUE)
                          ),
                          
                          #bin number slider input here
                          sliderInput(inputId="penguin_slider_input",
                                      label="Select number of bins",
                                      min=1,max= 100,
                                      value=25)
                          
                        ), # END penguin sidebar panel 
                        
                        
                        #pengiun mainbar panel
                        
                        mainPanel(
                          
                          #penguin scatterplot output ----
                          plotOutput(outputId="penguin_histogram_output")
                          
                        ) #END penguin main panel here
                        
                      ) #END penguin sidebar layout
                      
             ) # END penguin tab panel
             
             
           ) # END tabsetPanel
           
  ) # END page 2 intro tabPanel
  
  
) #END ui

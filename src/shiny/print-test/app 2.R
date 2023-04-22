# print-test ##
library(shiny)
library(shinyjs)
library(shinydashboard)
library(DT)

js_code <- "
shinyjs.browseURL = function(url) {
  window.open(url,'_blank');
}
"

URLs <- c("http://www.google.com", "Attendance-Checklist.html")



dbHeader <-   dashboardHeader(title = div("GOC Print test", 

                    
), 

tags$li(actionButton("openwindow","", onclick="openwin()",
          icon("print"),
          ),
        class = "dropdown", style = "padding: 10px 0;padding-right: 10px;")
)

ui <- dashboardPage(

    dbHeader,
    
    dashboardSidebar(),
    dashboardBody(
        # set up shiny js to be able to call our browseURL function
        useShinyjs(),
        extendShinyjs(text = js_code, functions = 'browseURL'),
        tags$script(HTML(
            '
            function openwin(){
                var x=window.open();
                const e=document.querySelector(".tab-content");
                x.document.open();
                x.document.write(e.outerHTML);
                x.document.close();
            }
            '
        )),
        tags$hr(),
        actionButton("openwindow", "New Window", onclick="openwin()"),  actionButton(
            "click",
            "Click here to open several browser tabs"
        ),
        tabsetPanel(
            id ="tabA",
            type = "tabs",
            tabPanel("Front",icon = icon("accusoft"),
                     plotOutput("ir")
            ),
            tabPanel("Data", icon = icon("table"),
                     dataTableOutput("iris")
            ),
            tabPanel("CheckList", icon = icon("report"),
                     htmlOutput("renderedReport")
            )
        )
    )
)

server <- function(input, output) {
    
    observeEvent(input$click, {
        for (i in URLs){
            js$browseURL(i)
            Sys.sleep(1)                #Short delay of 1 second
        }
    })
    
    output$ir<-renderPlot(
        plot(iris)
    )
    output$iris<-renderDataTable(
        iris
    )
    
    output$renderedReport <- renderUI({           
        includeMarkdown(knitr::knit('../../Attendance-Checklist.Rmd'))           
    })
}

shinyApp(ui = ui, server = server)

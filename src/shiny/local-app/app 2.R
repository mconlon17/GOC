# This is local-app
library(shiny)
library(shinydashboard)
library(DT)
library(RMySQL)
library(tidyverse)
library(rmarkdown)


ui <- dashboardPage(
    dashboardHeader(title="Test Date Widget"),
    dashboardSidebar(
        sidebarMenu(
            dateInput("date","Date",value=Sys.Date()),
            menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
            menuItem("Date user",tabName="date-user", icon = icon("calendar")),
            menuItem("A plot",tabName="plot-user", icon = icon("chart-line")),
            menuItem("A data table",tabName="table-user", icon = icon("table")),
            menuItem("HTML output",tabName="html-user", icon = icon("file-text")),
            menuItem(
                text = "Downloads",
                icon = icon("download"),
                downloadLink(
                    outputId = "dl_object1",
                    label = "Download members"
                ),
                tags$p(),
                downloadLink(
                    outputId = "dl_object2",
                    label = "Download emails"
                )
            )
        )
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName="dashboard",
                h2("GOC Dashboard"),
                p("This is a work in progress, identifying the information needs of the GOC", 
                  "and representing them here as reports, lists, tables, graphics, and downloads."),
            ),
            tabItem(tabName="date-user",
                textOutput("selected_var")
            ),
            tabItem(tabName="plot-user",
                plotOutput("plot_var")
            ),
            tabItem(tabName="table-user",
                dataTableOutput("table_var")
            ),
            tabItem(tabName="html-user",
                uiOutput("html_var")
            )
        )
    )
)

server <- function(input, output) { 
    
    output$selected_var <- renderText({ 
        paste("You have selected", input$date)
    })
    
    output$plot_var <- renderPlot({ 
        plot(seq(1,10),runif(10),main=input$date)
    })
    
    output$table_var <- renderDT({ 
        get.members()
    })
    
    output$html_var <- renderUI({ 
        HTML(markdown::markdownToHTML(render("../../New-Members.Rmd", params=list(date=input$date),
                                             quiet = TRUE), fragment.only=TRUE))
    })
    
    output$dl_object1 <- downloadHandler(
        filename = function() {
            paste0("object1.csv")
        },
        content = function(file) {
            write.csv(iris[1:10,], file = file)
        }
    )
    
    output$dl_object2 <- downloadHandler(
        filename = function() {
            paste0("object2.csv")
        },
        content = function(file) {
            write.csv(iris[10:20,], file = file)
        }
    )
    
}

shinyApp(ui, server)

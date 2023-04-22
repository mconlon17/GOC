# This is big-menu

library(shiny)
library(shinydashboard)
library(knitr)
library(shinyjs)
library(rmarkdown)

ui <- function(){
    dashboardPage(
    dashboardHeader(title="GOC Test"),
    dashboardSidebar(
        sidebarMenu(
            dateInput("date", "Date", value = Sys.Date()),
            menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
            menuItem("Attendance",
                menuSubItem("Sign-In Sheet", tabName = "sign-in-sheet"),
                menuSubItem("Attendance Check List", tabName = "attendance-check-list"),
                menuSubItem("Active Member Outreach List", tabName = "active-member-outreach-list"),
                menuSubItem("All Member Outreach List", tabName = "all-member-outreach-list"),
                menuSubItem("By Year and Person Type", tabName = "attendance-by-year-and-person-type")
                ),
            menuItem("Members",
                     menuSubItem("New Members", tabName = "new-members"),
                     menuSubItem("Allergies", tabName = "allergies"),
                     menuSubItem("Supports", tabName = "supports"),
                     menuSubItem("Progress Notes", tabName = "progress-notes"),
                     menuSubItem("Goals and Plans", tabName = "goals-and-plans")
                ),
            menuItem("Donors and Gifts",
                     menuSubItem("Top Donors", tabName = "top-donors"),
                     menuSubItem("Organizations Check List", tabName = "organizations-check-list"),
                     menuSubItem("Families Check List", tabName = "families-check-list"),
                     menuSubItem("People Check List", tabName = "people-check-list"),
                     menuSubItem("Gifts by Campaign", tabName = "gifts-by-campaign"),
                     menuSubItem("By Year and Source", tabName = "gifts-by-year-and-source"),
                     menuSubItem("By Calendar Year", tabName = "gifts-by-calendar-year")
                ),
            menuItem("Billing and Payroll",
                     menuSubItem("Billing List", tabName = "billing-list"),
                     menuSubItem("Staff Attendance List", tabName = "staff-attendance-list")
                ),
            menuItem("Productivity",
                menuSubItem("Flourish Record Counts", tabName = "flourish-record-counts"),
                menuSubItem("Supports by Staff", tabName = "supports-by-staff")
                )
            )
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName="dashboard",
                    h2("GOC Hosting Test"),
                    p("This is a work in progress, identifying the information needs of the GOC and representing them here as reports, lists, tables, and graphics."),
                    p("Staff and Members are working together to identify information needs that can be met using data stored in Flourish.  Recall our basic pathway for information:"),
                    code("Data Collection -> Data entry -> Checking -> Reporting"),
                    p("An example is attendance.  Attendance is our fundamental process, resulting in data used in billing, reporting to staff, members, management, the board, funding agencies, and the community."),
                    p("As we consider our information needs, we should consider our information processes -- from collection through reading a report, using a list, or viewing a graph. Some questions:"),
                    tags$ul(
                        tags$li("How was the data collected?  By Who? When? Where? How might collection be improved?"),
                        tags$li("How was the data entry performed?  As a side-by-side task with Members?  If not, why not?"),
                        tags$li("How was the data checked?  How were errors corrected?  Is the process written down? Is it done with Members?"),
                        tags$li("What lists, reports, downloaded-data, charts, or other data products are needed?  Are they available from this dashboard? If not, how might they be?")
                    ),
                    p("GOC is beginning its data journey along with the San Antonio Clubhouse, the Florida Clubhouse Coalition, and many others."),
            ),
            
            tabItem(tabName="sign-in-sheet",
                    h2(paste0("Sign-in Sheet"))),
            tabItem(tabName="attendance-check-list",
                    h2("Attendance Checklist")),
            tabItem(tabName = "active-member-outreach-list",
                    h2("Active Member Outreach List")),
            tabItem(tabName = "all-member-outreach-list",
                    h2("All Member Outreach List")),
            tabItem(tabName = "attendance-by-year-and-person-type",
                    HTML(markdown::markdownToHTML(knit("../../Attendance-By-Year-And-Person-Type.Rmd", quiet = TRUE), fragment.only=TRUE))),
            
            tabItem(tabName="new-members",
                    HTML(markdown::markdownToHTML(render("../../New-Members.Rmd", quiet = TRUE), fragment.only=TRUE))),
            tabItem(tabName="allergies",
                    h2("Allergies")),
            tabItem(tabName="supports",
                    h2("Supports")),
            tabItem(tabName = "progress-notes",
                    h2("Progress Notes")),
            tabItem(tabName = "goals-and-plans",
                    h2("Goals and Plans")),
            
            tabItem(tabName="top-donors",
                    h2("Top Donors")),
            tabItem(tabName = "organizations-check-list",
                    h2("Organizations Check List")),
            tabItem(tabName = "families-check-list",
                    h2("Families Check List")),
            tabItem(tabName="people-check-list",
                    h2("People Check List")),
            tabItem(tabName = "gifts-by-campaign",
                    h2("Gifts By Campaign")),
            tabItem(tabName = "gifts-by-year-and-source",
                    h2("Gifts By Year and Source")),
            tabItem(tabName="gifts-by-year",
                    h2("Gifts By Year")),
            
            tabItem(tabName = "billing-list",
                    h2("Billing List")),
            tabItem(tabName="staff-attendance-list",
                    h2("Staff Attendance List")),
            
            tabItem(tabName = "flourish-record-counts",
                    HTML(markdown::markdownToHTML(render("../../Flourish-Record-Counts.Rmd", quiet = TRUE, params=list(date=Sys.Date())),fragment.only=TRUE))),
            tabItem(tabName="supports-by-staff",
                    h2("Supports By Staff"))
        ),
        )
    )
}

server <- function(input, output) { 
    
    # previousSelection <- reactiveVal(isolate(input$sidebarItemExpanded))
    # observeEvent(input$sidebarItemExpanded, {
    #     if(!is.null(input$sidebarItemExpanded)){
    #         removeCssClass(class = "fa-angle-down", selector = "#sidebarItemExpanded > ul > li.treeview.active > a > i")
    #         addCssClass(class = "fa-angle-up", selector = "#sidebarItemExpanded > ul > li.treeview.active > a > i")
    #         
    #         if(!is.null(previousSelection())){
    #             if(input$sidebarItemExpanded != previousSelection()){
    #                 addCssClass(class = "fa-angle-down", selector = "#sidebarItemExpanded > ul > li > a > i")
    #                 removeCssClass(class = "fa-angle-up", selector = "#sidebarItemExpanded > ul > li > a > i")
    #                 removeCssClass(class = "fa-angle-down", selector = "#sidebarItemExpanded > ul > li.treeview.active > a > i")
    #                 addCssClass(class = "fa-angle-up", selector = "#sidebarItemExpanded > ul > li.treeview.active > a > i")
    #             }
    #         }
    #         
    #         previousSelection(input$sidebarItemExpanded)
    #         
    #     } else {
    #         addCssClass(class = "fa-angle-down", selector = "#sidebarItemExpanded > ul > li > a > i")
    #         removeCssClass(class = "fa-angle-up", selector = "#sidebarItemExpanded > ul > li > a > i")
    #     }
    # }, ignoreNULL = FALSE)
    
    }


shinyApp(ui = ui, server = server)
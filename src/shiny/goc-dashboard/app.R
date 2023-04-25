# This is goc-dashboard

library(shiny)
library(shinydashboard)
library(DT)
library(RMySQL)
library(tidyverse)
library(lubridate)
library(rmarkdown)
library(knitr)
library(uuid)
library(flextable)
library(officer)

dbHeader <- dashboardHeader(title = "GOC Dashboard")

ui <- dashboardPage(
  dbHeader,
  dashboardSidebar(
    width = 350,
    sidebarMenu(
      dateInput("date", "Date", value = Sys.Date()),
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      
      menuItem(
        "Members",
        menuSubItem("Active Members Assigned to Staff", tabName = "active-members-assigned-to-staff"),
        menuSubItem("New Members", tabName = "new-members"),
        menuSubItem("Birthdays", tabName = "birthdays"),
        menuSubItem("Allergies", tabName = "allergies"),
        menuSubItem("Accessibility Restrictions", tabName = "accessibility"),
        menuSubItem("Veterans", tabName = "veterans"),
        menuSubItem("Referral Summary", tabName = "referral-summary"),
        menuSubItem("Active Member Goals by Staff Member", tabName = "active-member-goals-by-staff-member"),
        menuSubItem("Monthly Member Progress Notes", tabName = "monthly-member-progress-notes"),
        menuSubItem("Monthly Supports by Member", tabName = "monthly-supports-by-member"),
        menuSubItem("Support Types by Year", tabName = "support-types-by-year"),
        menuSubItem("Membership By The Numbers", tabName = "membership-by-the-numbers"),
        menuSubItem("Unique Members By Year", tabName = "unique-members-by-year"),
        menuSubItem("Members By City And County", tabName = "members-by-city-and-county"),
        menuItem(
          "Member Graphics",
          icon = icon("chart-line"),
          menuSubItem("Daily Supports by Type", tabName = "daily-supports-by-type")
        ),
        menuItem(
          "Member Checks",
          icon = icon("circle-check"),
          menuSubItem("Check Active Members", tabName = "check-active-members"),
          menuSubItem("Check All Members", tabName = "check-all-members"),
          menuSubItem("Check Goals", tabName = "check-goals"),
          menuSubItem("Check Progress Notes", tabName = "check-progress-notes"),
          menuSubItem("Check Supports", tabName = "check-supports")
        )
      ),
      
      menuItem(
        "Attendance and Outreach",
        menuSubItem("Member Sign-In Sheet", tabName = "member-sign-in-sheet"),
        menuSubItem("Visitor Sign-In Sheet", tabName = "visitor-sign-in-sheet"),
        menuSubItem("Attendance Check List", tabName = "attendance-check-list"),
        menuSubItem("Active Member Outreach List", tabName = "active-member-outreach-list"),
        menuSubItem("All Member Outreach List", tabName = "all-member-outreach-list"),
        menuSubItem("Newly Absent Member List", tabName = "newly-absent-member-list"),
        menuSubItem("Monthly Attendance Summary", tabName = "monthly-attendance-summary"),
        menuItem(
          "Attendance Graphics",
          icon = icon("chart-line"),
          menuSubItem("Attendance by Month", tabName = "attendance-by-month"),
          menuSubItem("Attendance by Year and Person Type", tabName = "attendance-by-year-and-person-type"),
          menuSubItem("Active Members over Time", tabName = "active-members-over-time")
        ),
        menuItem(
          "Attendance and Outreach Checks",
          icon = icon("circle-check"),
          menuSubItem("Check Attendance", tabName = "check-attendance"),
          menuSubItem("Check Outreach", tabName = "check-outreach")
        )
      ),    
      
      menuItem(
        "Employment",
        menuSubItem("Current Employment", tabName = "current-employment"),
        menuItem(
          "Employment Checks",
          icon = icon("circle-check"),
          menuSubItem("Check Employment", tabName = "check-employment")
        )
      ),
      
      menuItem(
        "Contacts and Gifts",
        menuSubItem("All Donors", tabName = "all-donors"),
        menuSubItem("Gifts by Year, Month, and Payment Method", tabName = "gifts-by-year-month-and-payment-method"),
        menuSubItem("Organization Contact Info", tabName = "organization-contact-info"),
        menuSubItem("Family Contact Info", tabName = "family-contact-info"),
        menuSubItem("Person Contact Info", tabName = "person-contact-info"),
        menuSubItem("Gifts by Campaign", tabName = "gifts-by-campaign"),
        menuSubItem("Gift Amounts by Campaign", tabName = "gift-amounts-by-campaign"),
        menuItem(
          "Contact and Gift Graphics",
          icon = icon("chart-line"),
          menuSubItem("Gifts by Year", tabName = "gifts-by-year"),
          menuSubItem("Total Raised By Payment Method", tabName = "total-raised-by-payment-method"),
          menuSubItem("Number of Gifts vs Total Raised by Campaign", tabName = "number-of-gifts-vs-total-raised-by-campaign"),
          menuSubItem("Top 10 Campaigns by Number of Gifts", tabName = "top-10-campaigns-by-number-of-gifts")
        ),
        menuItem(
          "Contact and Gift Checks",
          icon = icon("circle-check"),
          menuSubItem("Check Contacts", tabName = "check-contacts"),
          menuSubItem("Check Gifts", tabName = "check-gifts")
        )
      ),
      
      menuItem(
        "Billing and Payroll",
        menuSubItem("Clubhouse Billing List", tabName = "billing-list"),
        menuSubItem("Supported Employment Billing List", tabName = "supported-employment-billing-list"),
        menuSubItem("Last Attendance in Month", tabName = "last-attendance-in-month-list"),
        menuSubItem("Staff Time Report", tabName = "staff-time-report"),
        selectInput(
          "staff_name", "Staff Member", get.staff.names()
        )
      ),

      menuItem(
        "Productivity",
        menuSubItem("Goal Types by Staff", tabName = "goal-types-by-staff"),
        menuSubItem("Progress Notes by Staff", tabName = "progress-notes-by-staff"),
        menuSubItem("Support Types by Staff", tabName = "support-types-by-staff")
      ),
      
      menuItem(
        "Technical",
        menuSubItem("Flourish Record Counts", tabName = "flourish-record-counts"),
        menuSubItem("Flourish Fields", tabName = "flourish-fields"),
        menuSubItem("Flourish Table Relationships", tabName = "flourish-table-relationships"),
        menuItem(
          "Technical Checks",
          icon = icon("circle-check"),
          menuSubItem("Check Users", tabName = "check-users")
        )
      ),
      
      menuItem(
        "Data Tables",
        icon = icon("table"),
        menuSubItem("Attendance", tabName = "table-attendance"),
        menuSubItem("Outreach", tabName = "table-outreach"),
        menuSubItem("Members", tabName = "table-members"),
        menuSubItem("Employment", tabName = "table-employment"),
        menuSubItem("Contacts", tabName = "table-contacts"),
        menuSubItem("Gifts", tabName = "table-gifts"),
        menuSubItem("Goals and Plans", tabName = "table-goals"),
        menuSubItem("Supports", tabName = "table-supports"),
        menuSubItem("Progress Notes", tabName = "table-progress-notes"),
        menuSubItem("Users", tabName = "table-users")
      ),
      menuItem(
        "Downloads",
        icon = icon("download"),
        downloadLink(outputId = "download_attendance", label = "Download Attendance"), tags$p(),
        downloadLink(outputId = "download_outreach", label = "Download Outreach"), tags$p(),
        downloadLink(outputId = "download_members", label = "Download Members"), tags$p(),
        downloadLink(outputId = "download_employment", label = "Download Employment"), tags$p(),
        downloadLink(outputId = "download_contacts", label = "Download Contacts"), tags$p(),
        downloadLink(outputId = "download_gifts", label = "Download Gifts"), tags$p(),
        downloadLink(outputId = "download_goals", label = "Download Goals and Plans"), tags$p(),
        downloadLink(outputId = "download_supports", label = "Download Supports"), tags$p(),
        downloadLink(outputId = "download_supports_with_members", label = "Download Supports with Members"), tags$p(),
        downloadLink(outputId = "download_progress_notes", label = "Download Progress Notes"), tags$p(),
        downloadLink(outputId = "download_users", label = "Download Flourish Users")
      )
    )
  ),
  dashboardBody(
    tabItems(

      # Dashboard
      tabItem(
        tabName = "dashboard",
        h2("GOC Dashboard"),
        p("This is a work in progress, identifying the information needs of the GOC",
          "and representing them here as reports, lists, tables, graphics, and downloads."),
        p("All planned reports and plots are now included in the dashboard.  Additional elements can be added as needed."),
        
        infoBox("Today", Sys.Date(), icon = icon("calendar"), color = "fuchsia", fill = TRUE),
        infoBox("Active Members", value=uiOutput("active_members"), icon = icon("users"), color = "green", fill = TRUE),
        box(title = "Bike Day 5/13", background = "navy", width = 4,
          p("At First Magnitude. See ",a("2nd Annual Bike Day",href="https://goclubhouse.org/2nd-annual-goc-bike-day/"))),
        
        box(title = "Membership Growth", status = "warning", solidHeader = TRUE, collapsible = TRUE, plotOutput("important_plot", height = 250)),
        box(title = "Gift Growth", status = "warning", solidHeader = TRUE, collapsible = TRUE, plotOutput("another_plot", height = 250)),
        
        infoBox("Today's Birthdays", value=uiOutput("todays_birthdays"), icon = icon("birthday-cake"), color = "fuchsia", fill = TRUE),
        infoBox("Average Daily Attendance", value=uiOutput("ada"), icon = icon("users"), color = "green", fill = TRUE),
        box( 
          title = "Flourish News",
          background = "navy",
          width = 4,
          p("Active Members Assigned to Staff now dynamic from Members"),
          p("Staff Name lists are now dynamic from Contacts"),
          p("Progress Bar added to Active Members Over Time")
        )
      ),

      # Attendance

      tabItem(tabName = "member-sign-in-sheet",               uiOutput("html_member_sign_in_sheet")),
      tabItem(tabName = "visitor-sign-in-sheet",              uiOutput("html_visitor_sign_in_sheet")),
      tabItem(tabName = "attendance-check-list",              uiOutput("html_attendance_check_list")),
      tabItem(tabName = "active-member-outreach-list",        uiOutput("html_active_member_outreach_list")),
      tabItem(tabName = "all-member-outreach-list",           uiOutput("html_all_member_outreach_list")),
      tabItem(tabName = "newly-absent-member-list",           uiOutput("html_newly_absent_member_list")),
      tabItem(tabName = "monthly-attendance-summary",         uiOutput("html_monthly_attendance_summary")),
      tabItem(tabName = "attendance-by-month",                plotOutput("plot_attendance_by_month")),
      tabItem(tabName = "attendance-by-year-and-person-type", plotOutput("plot_attendance_by_year_and_person_type")),
      tabItem(tabName = "active-members-over-time",           plotOutput("plot_active_members_over_time")),
      tabItem(tabName = "check-attendance",                   uiOutput("html_check_attendance")),
      tabItem(tabName = "check-outreach",                     uiOutput("html_check_outreach")),

      # Members
      
      tabItem(tabName = "active-members-assigned-to-staff",    uiOutput("html_active_members_assigned_to_staff")),
      tabItem(tabName = "new-members",                         uiOutput("html_new_members")),
      tabItem(tabName = "birthdays",                           uiOutput("html_birthdays")),
      tabItem(tabName = "allergies",                           uiOutput("html_allergies")),
      tabItem(tabName = "accessibility",                       uiOutput("html_accessibility")),
      tabItem(tabName = "veterans",                            uiOutput("html_veterans")),
      tabItem(tabName = "referral-summary",                    uiOutput("html_referral_summary")),
      tabItem(tabName = "monthly-supports-by-member",          uiOutput("html_monthly_supports_by_member")),
      tabItem(tabName = "support-types-by-year",               uiOutput("html_support_types_by_year")),
      tabItem(tabName = "active-member-goals-by-staff-member", uiOutput("html_active_member_goals_by_staff_member")),
      tabItem(tabName = "monthly-member-progress-notes",       uiOutput("html_monthly_member_progress_notes")),
      tabItem(tabName = "membership-by-the-numbers",           uiOutput("html_membership_by_the_numbers")),
      tabItem(tabName = "unique-members-by-year",              uiOutput("html_unique_members_by_year")),
      tabItem(tabName = "members-by-city-and-county",          uiOutput("html_members_by_city_and_county")), 
      tabItem(tabName = "daily-supports-by-type",              plotOutput("plot_daily_supports_by_type")),
      tabItem(tabName = "check-active-members",                uiOutput("html_check_active_members")),
      tabItem(tabName = "check-all-members",                   uiOutput("html_check_all_members")),
      tabItem(tabName = "check-goals",                         uiOutput("html_check_goals")),
      tabItem(tabName = "check-progress-notes",                uiOutput("html_check_progress_notes")),
      tabItem(tabName = "check-supports",                      uiOutput("html_check_supports")),

      # Contacts and Gifts

      tabItem(tabName = "all-donors",                                  uiOutput("html_all_donors")),
      tabItem(tabName = "gifts-by-year-month-and-payment-method",      uiOutput("html_gifts_by_year_month_and_payment_method")),
      tabItem(tabName = "organization-contact-info",                   uiOutput("html_organization_contact_info")),
      tabItem(tabName = "family-contact-info",                         uiOutput("html_family_contact_info")),
      tabItem(tabName = "person-contact-info",                         uiOutput("html_person_contact_info")),
      tabItem(tabName = "gifts-by-campaign",                           uiOutput("html_gifts_by_campaign")),
      tabItem(tabName = "gift-amounts-by-campaign",                    uiOutput("html_gift_amounts_by_campaign")),
      tabItem(tabName = "gifts-by-year",                               plotOutput("plot_gifts_by_year")),
      tabItem(tabName = "total-raised-by-payment-method",              plotOutput("plot_total_raised_by_payment_method")),
      tabItem(tabName = "number-of-gifts-vs-total-raised-by-campaign", plotOutput("plot_number_of_gifts_vs_total_raised_by_campaign")),
      tabItem(tabName = "top-10-campaigns-by-number-of-gifts",         plotOutput("plot_top_10_campaigns_by_number_of_gifts")),
      tabItem(tabName = "check-contacts",                              uiOutput("html_check_contacts")),
      tabItem(tabName = "check-gifts",                                 uiOutput("html_check_gifts")),
      
      # Billing and Payroll

      tabItem(tabName = "billing-list",                      uiOutput("html_billing_list")),
      tabItem(tabName = "supported-employment-billing-list", uiOutput("html_supported_employment_billing_list")),
      tabItem(tabName = "last-attendance-in-month-list",     uiOutput("html_last_attendance_in_month_list")),
      tabItem(tabName = "staff-time-report",                 uiOutput("html_staff_time_report")),
      
      # Employment
      
      tabItem(tabName = "current-employment",      uiOutput("html_current_employment")),
      tabItem(tabName = "check-employment",        uiOutput("html_check_employment")), 

      # Productivity

      tabItem(tabName = "goal-types-by-staff",     uiOutput("html_goal_types_by_staff")),
      tabItem(tabName = "progress-notes-by-staff", uiOutput("html_progress_notes_by_staff")),
      tabItem(tabName = "support-types-by-staff",  uiOutput("html_support_types_by_staff")),

      
      # Technical
      
      tabItem(tabName = "flourish-record-counts",       uiOutput("html_flourish_record_counts")),
      tabItem(tabName = "flourish-fields",              uiOutput("html_flourish_fields")),
      tabItem(tabName = "flourish-table-relationships", imageOutput("png_flourish_table_relationships")),
      tabItem(tabName = "check-users",                  uiOutput("html_check_users")),

      # Data Tables

      tabItem(tabName = "table-attendance",     dataTableOutput("table_attendance")),
      tabItem(tabName = "table-outreach",       dataTableOutput("table_outreach")),
      tabItem(tabName = "table-members",        dataTableOutput("table_members")),
      tabItem(tabName = "table-employment",     dataTableOutput("table_employment")),
      tabItem(tabName = "table-contacts",       dataTableOutput("table_contacts")),
      tabItem(tabName = "table-gifts",          dataTableOutput("table_gifts")),
      tabItem(tabName = "table-goals",          dataTableOutput("table_goals")),
      tabItem(tabName = "table-supports",       dataTableOutput("table_supports")),
      tabItem(tabName = "table-progress-notes", dataTableOutput("table_progress_notes")),
      tabItem(tabName = "table-users",          dataTableOutput("table_users"))

      # Downloads
    )
  )
)

server <- function(input, output) {
  
  shinyAppDir(".")
  
  # Dashboard
    
  output$active_members   <- renderText({ nrow(get.members(active.only=T)) })
  
  output$todays_birthdays <- renderText({ get.birthdays() })
  
  output$ada              <- renderText({ format(round(get.ada(30), 1), nsmall = 1) }) 
  
  output$important_plot   <- renderPlot({ plot.member.attendance.by.month(input$date) })  
  
  output$another_plot     <- renderPlot({ plot.gifts.by.year(input$date) })
  
  # Attendance

  output$html_member_sign_in_sheet <- renderUI({
    HTML(markdown::markdownToHTML(render("src/member-sign-in-sheet.Rmd",
      params = list(date = input$date),
      quiet = TRUE
    ), fragment.only = TRUE))
  })

  output$html_visitor_sign_in_sheet <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Visitor-Sign-In-Sheet.Rmd",
      params = list(date = input$date),
      quiet = TRUE
    ), fragment.only = TRUE))
  })

  output$html_attendance_check_list <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Attendance-Checklist.Rmd",
      params = list(date = input$date),
      quiet = TRUE
    ), fragment.only = TRUE))
  })

  output$html_active_member_outreach_list <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Active-Member-Outreach-List.Rmd",
      params = list(date = input$date),
      quiet = TRUE
    ), fragment.only = TRUE))
  })

  output$html_all_member_outreach_list <- renderUI({
    HTML(markdown::markdownToHTML(render("src/All-Member-Outreach-List.Rmd",
      params = list(date = input$date),
      quiet = TRUE
    ), fragment.only = TRUE))
  })
  
  output$html_newly_absent_member_list <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Newly-Absent-Member-List.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_monthly_attendance_summary <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Monthly-Attendance-Summary.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })

  output$plot_attendance_by_month <- renderPlot({
    plot.member.attendance.by.month(input$date)
  })
  
  output$plot_attendance_by_year_and_person_type <- renderPlot({
    plot.attendance.by.year.and.person.type()
  })

  output$plot_active_members_over_time <- renderPlot({
    plot.active.members.over.time(input$date)
  })
  
  output$html_check_attendance <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Check-Attendance.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_check_outreach <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Check-Outreach.Rmd", quiet = TRUE), fragment.only = TRUE))
  })

  # Members
  
  output$html_active_members_assigned_to_staff <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Active-Members-Assigned-To-Staff.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })

  output$html_new_members <- renderUI({
    HTML(markdown::markdownToHTML(render("src/New-Members.Rmd",
      params = list(date = input$date),
      quiet = TRUE
    ), fragment.only = TRUE))
  })

  output$html_birthdays <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Birthdays.Rmd",
      params = list(date = input$date),
      quiet = TRUE
    ), fragment.only = TRUE))
  })
  
  output$html_allergies <- renderUI({
      HTML(markdown::markdownToHTML(render("src/Allergies.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_accessibility <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Accessibility.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_veterans <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Veterans.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_referral_summary <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Referral-Summary.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_monthly_supports_by_member <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Monthly-Supports-By-Member.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_support_types_by_year <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Support-Types-By-Year.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_active_member_goals_by_staff_member <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Active-Member-Goals-By-Staff-Member.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_monthly_member_progress_notes <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Monthly-Member-Progress-Notes.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_membership_by_the_numbers <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Membership-By-The-Numbers.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_unique_members_by_year <- renderUI({
      HTML(markdown::markdownToHTML(render("src/Unique-Members-By-Year.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_members_by_city_and_county <- renderUI({
      HTML(markdown::markdownToHTML(render("src/Members-By-City-And-County.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })
  
  output$plot_daily_supports_by_type <- renderPlot({
    plot.daily.supports.by.type(input$date)
  })
  
  output$html_check_active_members <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Check-Active-Members.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_check_all_members <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Check-All-Members.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_check_goals <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Check-Goals.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_check_progress_notes <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Check-Progress-Notes.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_check_supports <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Check-Supports.Rmd", quiet = TRUE), fragment.only = TRUE))
  })

  # Contacts and Gifts

  output$html_all_donors <- renderUI({
    HTML(markdown::markdownToHTML(render("src/All-Donors.Rmd",
      quiet = TRUE
    ), fragment.only = TRUE))
  })

  output$html_gifts_by_year_month_and_payment_method <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Gifts-By-Year-Month-And-Payment-Method.Rmd",
      quiet = TRUE
    ), fragment.only = TRUE))
  })
  
  output$html_organization_contact_info <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Organization-Contact-Info.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_family_contact_info <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Family-Contact-Info.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_person_contact_info <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Person-Contact-Info.Rmd", quiet = TRUE), fragment.only = TRUE))
  })

  output$html_gifts_by_campaign <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Gifts-By-Campaign.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_gift_amounts_by_campaign <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Gift-Amounts-By-Campaign.Rmd", quiet = TRUE), fragment.only = TRUE))
  })

  output$plot_gifts_by_year <- renderPlot({
    plot.gifts.by.year(input$date)
  })
  
  output$plot_total_raised_by_payment_method <- renderPlot({
    plot.total.raised.by.payment.method(input$date)
  })
  
  output$plot_number_of_gifts_vs_total_raised_by_campaign <- renderPlot({
    plot.number.of.gifts.vs.total.raised.by.campaign()
  })
  
  output$plot_top_10_campaigns_by_number_of_gifts <- renderPlot({
    plot.top.10.campaigns.by.number.of.gifts()
  })
  
  output$html_check_contacts <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Check-Contacts.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_check_gifts <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Check-Gifts.Rmd", quiet = TRUE), fragment.only = TRUE))
  })

  # Billing and Payroll

  output$html_billing_list <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Billing-List.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_supported_employment_billing_list <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Supported-Employment-Billing-List.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })

  output$html_last_attendance_in_month_list <- renderUI({
    HTML(markdown::markdownToHTML(render("src/last-attendance-in-month-list.Rmd",
      params = list(date = input$date),
      quiet = TRUE
    ), fragment.only = TRUE))
  })

  output$html_staff_time_report <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Staff-Time-Report.Rmd",
      params = list(start_date = input$date, name = input$staff_name),
      quiet = TRUE
    ), fragment.only = TRUE))
  })
  
  # Employment
  
  output$html_current_employment <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Current-Employment.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_check_employment <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Check-Employment.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  

  # Productivity
  
  output$html_goal_types_by_staff <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Goal-Types-By-Staff.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_progress_notes_by_staff <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Progress-Notes-By-Staff.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_support_types_by_staff <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Support-Types-By-Staff.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })

  
  # Technical
  
  output$html_flourish_record_counts <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Flourish-Record-Counts.Rmd", params = list(date = input$date), quiet = TRUE), fragment.only = TRUE))
  })
  
  output$html_flourish_fields <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Flourish-Fields.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  output$png_flourish_table_relationships <- renderImage({
    list(src = "img/Flourish-Table-Relationships.png", contentType = 'image/png', width = 1131, height = 671, alt = "ERD-like diagram of key linkage between tables")
  },deleteFile=FALSE)
  
  output$html_check_users <- renderUI({
    HTML(markdown::markdownToHTML(render("src/Check-Users.Rmd", quiet = TRUE), fragment.only = TRUE))
  })
  
  
  # Data Tables

  output$table_attendance <- renderDT({
    get.attendance()
  })

  output$table_outreach <- renderDT({
    get.outreach()
  })

  output$table_members <- renderDT({
    get.members()
  })
  
  output$table_employment <- renderDT({
    get.employment()
  })

  output$table_contacts <- renderDT({
    get.contacts()
  })

  output$table_gifts <- renderDT({
    get.gifts()
  })

  output$table_goals <- renderDT({
    get.goals()
  })

  output$table_supports <- renderDT({
    get.supports()
  })

  output$table_progress_notes <- renderDT({
    get.progress.notes()
  })
  
  output$table_users <- renderDT({
    get.users()
  })

  # Downloads

  output$download_attendance <- downloadHandler(
    filename = function() {
      paste0("flourish-attendance-", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(get.attendance(), file = file)
    })
    



  output$download_outreach <- downloadHandler(
    filename = function() {
      paste0("flourish-outreach-", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(get.outreach(), file = file)
    }
  )

  output$download_members <- downloadHandler(
    filename = function() {
      paste0("flourish-members-", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(get.members(), file = file)
    }
  )

  output$download_contacts <- downloadHandler(
    filename = function() {
      paste0("flourish-contacts-", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(get.contacts(), file = file)
    }
  )

  output$download_gifts <- downloadHandler(
    filename = function() {
      paste0("flourish-gifts-", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(get.gifts(), file = file)
    }
  )

  output$download_goals <- downloadHandler(
    filename = function() {
      paste0("flourish-goals-", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(get.goals(), file = file)
    }
  )

  output$download_supports <- downloadHandler(
    filename = function() {
      paste0("flourish-supports-", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(get.supports(), file = file)
    }
  )
  
  output$download_supports_with_members <- downloadHandler(
    filename = function() {
      paste0("flourish-supports-with-members-", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(get.supports(with.members=T), file = file)
    }
  )

  output$download_progress_notes <- downloadHandler(
    filename = function() {
      paste0("flourish-progress-notes-", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(get.progress.notes(), file = file)
    }
  )
  
  output$download_employment <- downloadHandler(
    filename = function() {
      paste0("flourish-employment-", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(get.employment(), file = file)
    }
  )
  
  output$download_users <- downloadHandler(
    filename = function() {
      paste0("flourish-users-", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(get.users(), file = file)
    }
  )
  
}

shinyApp(ui, server)

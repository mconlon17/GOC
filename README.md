# Gainesville Opportunity Center

The [Gainesville Opportunity Center](https://goclubhouse.org) (GOC) is using R to create reports, including listings,
summaries, billing data, email lists for solicitation, board reports, and graphics.  These reports will be accessible from [Flourish](https://clubhousedata.org/), the hosted GOC data system by [Form Communities](https://formcommunities.org/)

A dashboard is being built using [Shiny](https://shiny.rstudio.com/) to organize reports and other data presentations from Flourish.  The dashboard will be hosted by Form Communities.

## Modules

The GOC has implemented 10 Flourish modules:

1. Members. Just Members.  Prospects are in Contacts.
1. Contacts. All Members are contacts, but not all contacts are Members.  Contacts include donors, volunteers, community partners, staff, and many others.
1. Gifts. All gifts, including in-kind.
1. Attendance.  All attendance, including staff, visitors, and volunteers.
1. Outreach.  Outreach to Members.
1. Employment.  One record per "employment" -- start/end with a specific employer.  Employers are in Contacts.
1. Supports.  One record per support -- Members and a Staff Member participating in a clubhouse activity.
1. Goals and Plans.  One record per goal with associated plan.  Members have multiple goals.
1. Progress Notes.  One progress note per month per goal.
1. Users.  The users of the system, including access roles.

## Dashboard

The GOC Dashboard has 3 widgets, 49 reports, 8 plots, 10 table viewers, 1 technical figure, and 11 downloads. 

![Screen shot of GOC dashboard with menu on left, 3 info boxes on the right, two graphs underneath the info boxes, and three more info boxes on the bottom](img/Dashboard-2023-04-23.png)

Some highlights:

* Members with staff assignments showing attendance, supports, goals, and progress notes
* Sign in sheets, attendance and outreach reports
* Donations by year, campaign, top donors
* Billing reports for grants
* Payroll reports for staff
* Productivity reports
* Board reporting
* System information including database record counts, and field usage by table

# Gainesville Opportunity Center

The [Gainesville Opportunity Center](https://goclubhouse.org) (GOC) is using R to create reports, including listings,
summaries, billing data, email lists for solicitation, board reports, and graphics.  These reports will be accessible from [Flourish](https://clubhousedata.org/), the hosted GOC data system by [Form Communities](https://formcommunities.org/)

A dashboard is being built using [Shiny](https://shiny.rstudio.com/) to organize reports and other data presentations from Flourish.  The dashboard will be hosted by Form Communities.

## Modules

The GOC has implemented 10 Flourish modules:

1. Members. Just Members.  Prospects are in Contacts.
1. Contacts. All Members are contacts, but not all contacts are Members.  Contacts include donors, volunteers, community partners, staff, and many others.
1. Gifts. All gifts, including in-kind.
1. Attendance.  All attendnace, including staff, visitors, and volunteers.
1. Outreach.  Outreach to Members.
1. Employment.  One record per "employment" -- start/end with a specific employer.  Employers in Contacts.
1. Supports.  One record per support -- a group on Members and a Staff Member participating in a clubhouse activity.
1. Goals and Plans.  One record per goal with associated plan.  Members have multiple goals.
1. Progress Notes.  One progress note per month per goal.
1. Users.  The users of the sstem, including accesss roles.

### Future Modules

The GOC plans to implement

1. Education.  One record per "education" -- start/end with a specific education program.  Education providers in contacts.
1. Group Event.  One record per event -- date/time/locsation/duration.  With associated members and staff.

## Reports and their cycles

### Daily

* Daily Attendance Lists -- Member, Staff/Volunteer, and Visitor sign-up sheets
* Newly Absent Member List -- lists Members who have not attended for more than 90 days
* Outreach List -- lists Members with date of last attendace for use in Outreach
* *Record tracking -- for each module, show new records added and records updated. For process monitoring*

### Weekly

* Member Locations -- shows cities, states and zip codes for members.  Used in error checking
* Supports -- lists supports by staff, member, and type for tracking support data entry

### Monthly or so

* Billing List -- used to produce the monthly invoice to LSF
* *Board report -- bi-monthly report to the board*
* Donations by Campaign -- shows donations to each campaign since 2017
* Last attendance in month -- used in Supplemental Employment billing of LSF
* Monthly attendance summary -- used by management to track attendance at work ordered day, social, and holiday events


### Quarterly or so

* Attendance plot -- shows GOC attendance since 2008

### Adhoc

* Campaign donor report -- run for the campaign as needed
* Contact email addresses -- run as needed for bulk email
* Contact missing data report -- shows missing data for contact for remediation
* Member missing data report -- shows missing data for Members for remediation


## Notes
1. We don't recommend yearly reports -- everything should be checked and reported more frequently than yearly.  So while
a final report may only be needed yearly, intermediate reports should be run to anticipate the yearly version.
1. We don't recommend adhoc reports -- everything should be on a schedule so that reports are not overlooked.

## To Do

1. Modify reports as needed for operational use at the GOC.  Columns will be added or removed, wording improved to meet operational needs.
1. Add reports as need for operational use at the GOC.  Some anticipated reports are:
    1. ARPA billing report -- when requirements are developed
    1. Wellness billing report -- when event attendance is implemented
    1. Education tracking report -- when education tracking is implemented
    1. Transportation tracking report -- when transportation logging is implemented

## Utility programs

* Flourish Connection -- tests the Flourish connection showing status, and columns in tables GOC uses for reporting
* Flourish Get -- basic getter type functions for returning data from a Flourish databse and making it available to R

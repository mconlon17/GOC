---
title: GOC R Project
author: Michael Conlon
date: 2023-02-05
output:
  html_document: default
  pdf_document: default
  word_document: default
---

The [Gainesville Opportunity Center](https://goclubhouse.org) is using R to create reports, including listings,
summaries, billing data, email lists for solicitation, board reports, and graphics.  These reports will be accessible from Flourish, the hosted
GOC data system by San Antonio Clubhouse.

A dashboard is being built using R Shiny to organize reports and other data presentations from Flourish.  The dashboard will be hosted by the San Antonio Clubhouse.

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
* *Contact email addresses -- run as needed for bulk email*
* *Contact missing data report -- shows missing data for contact for remediation*
* *Member missing data report -- shows missing data for Members for remediation*


## Notes
1. We don't recommend yearly reports -- everything should be checked and reported more frequently than yearly.  So while
a final report may only be needed yearly, intermediate reports should be run to anticipate the yearly version.
1. We don't recommend adhoc reports -- everything should be aon a schedule so that reports are not overlooked.
1. Italicized reports are under development.  All other reports have been written and tested with either Applistic, or fictional data. The board report will not be completed until education and employment tracking have been added to Flourish.

## To Do

1. Pull data from Flourish tables and update test programs to use live data.  The draft R reports are asily modified to pull data from Flourish rather than CSV files.  Reports will be updated when data is available in Flourish.
1. Use R server and Shiny Apps, or other technology, to create reproducible,
end-user activated reports.  The current R setup must be run by an experienced R user from a desktop computer 
and made available via print or web site to end users, and this setup will
need to be replaced with a few weeks.
1. Improve formatting in PDF and Word -- the HTML reports look good and load well in Word.  This may be sufficient.
1. Add data checking reports and lists -- data checking is on-going work of the Office Unit
1. Modify reports as needed for operational use at the GOC.  Columns will be added or removed, wording improved to meet operational needs.
1. Add reports as need for operational use at the GOC.  Some anticipated reports are:
    1. ARPA billing report -- when requirements are developed
    1. Wellness billing report -- when event attendance is implemented
    1. Education tracking report -- when education tracking is implemented
    1. Employment tracking report -- when employment tracking is implemented
    1. Transportation tracking report -- when transportation logging is implemented
    

## Utility programs

* Flourish Connection -- tests the Flourish connection showing status, and columns in tables GOC uses for reporting
* Flourish Get -- basic getter type functions for returning data from a Flourish databse and making it available to R

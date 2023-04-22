# Manifest

1. ```styles``` -- CSS for HTML.  This seems to work well in the dashboard, stand-alone, and for printing. Reports and plots can be opened in a browser window and printed using standard browser and operating system features.
1. ```src``` -- all  source code.  R Markdown files, R functions, ```setup.R``` See any ```.Rmd``` file for examples.
1. ```src/clean``` -- scripts for cleaning data.  Your mileage will vary.
1. ```src/load``` -- scripts for loading data from CSV files.  Member data was loaded in chunks.  All other tables were loaded using a single script.  Employment and Users were hand-entered.  No data is included.  These scripts are examples.
1. ```src/shiny``` -- scripts for use in the Shiny dashboard.  Several test dashboards are included.
1. ```src/shiny/goc-dashboard``` -- The GOC Dashboard files
1. ```src/shiny/goc-dashboard/app.R``` -- the GOC dashboard main file showing menu layout, ui and server components.
1. ```src/shiny/goc-dashboard/img``` -- image files used by the GOC dashboard
1. ```src/shiny/goc-dashboard/rsconnect``` -- rsconnect files for Rstudio
1. ```src/shiny/goc-dashboard/src``` -- R and R Markdown sourcee files for the GOC dashboard
1. ```src/shiny/goc-dashboard/styles``` -- CSS files for the GOC dashboard

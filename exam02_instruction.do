** Project Name: IMF Mock Exam
** Name:
** Date: 

clear
set more off
cd "" // Enter your working path here, store all files to the working path

************************************
** Part 1. Data Preparation
************************************

* Q1. Please import data from the sheet "Data", make sure all economic indicators are stored as numeric variables, then save as "weo1.dta"

* Q2. Please import data from the sheet "Merge", make sure all economic indicators are stored as numeric variables, then reshape the data to an ideal format and merge with weo1.dta that you just created; keep only observations that matched
// note: you may need to replace the SubjectDescriptor variable before reshape
// try these codes:
// replace SubjectDescriptor = "s" if SubjectDescriptor == "Gross national savings"
// replace SubjectDescriptor = "i" if SubjectDescriptor == "Total investment"

//make sure after reshaping, the saving variable is named as s, and the investment variable is named as i

* Q3. Please order the database with the following sequence: id WEO_Code Country Year gdp xm ur pop i s; then sort by id

* Q4. Please keep the obs between year 1995 and 2026

************************************
** Part 2. Panel Analysis
************************************

* Q5. Please use panel command (xtset) to create a variable which is the percentage change of GDP on an annual basis for each country

* Q6. Please use panel command (xtset) to create variables which is the percentage change of Population, Savings, and Investment on an annual basis for each country

************************************
** Part 3. Regression and Forecast
************************************

/*
* Q7. Please run a series of multivariate fixed effect regressions using 2000 to 2018 data only: 
(1) percent change in gdp on percent change in population, controling for percent change in saving
(2) percent change in gdp on percent change in population, controling for percent change in investment
(3) percent change in gdp on percent change in population, controling for both percent changes in saving and investment
*/

* Q8. Please export the regression results to a .xls file, then copy the results to the "EXAM02 ..." workbook, sheet "Report" columns A:D.
// outreg2 is recommended here

* Q9. Please predict two post-estimation indicators: the fitted value (xb) and the fixed effect (u) for the third model



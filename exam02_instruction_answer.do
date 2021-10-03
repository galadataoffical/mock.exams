** Project Name: IMF Mock Exam
** Name:
** Date: 

clear
set more off
cd "E:\★ 跨越数据银河\★ 模拟考试" // Enter your working path here, store all files to the working path

************************************
** Part 1. Data Preparation
************************************

* Q1. Please import data from the sheet "Data", make sure all economic indicators are stored as numeric variables, then save as "weo1.dta"
import excel using "EXAM02. International Monetary Fund Excel Exam_GDP Data_version July_21_2021", sheet("Data") firstrow clear
destring gdp-pop, force replace
save weo1.dta, replace

* Q2. Please import data from the sheet "Merge", make sure all economic indicators are stored as numeric variables, then reshape the data to an ideal format and merge with weo1.dta that you just created; keep only observations that matched
// note: you may need to replace the SubjectDescriptor variable before reshape
// try these codes:
// replace SubjectDescriptor = "s" if SubjectDescriptor == "Gross national savings"
// replace SubjectDescriptor = "i" if SubjectDescriptor == "Total investment"

import excel using "EXAM02. International Monetary Fund Excel Exam_GDP Data_version July_21_2021", sheet("Merge") firstrow clear
destring D-AX, force replace
replace SubjectDescriptor = "s" if SubjectDescriptor == "Gross national savings"
replace SubjectDescriptor = "i" if SubjectDescriptor == "Total investment"
foreach v of varlist D-AX {
local vlabel: variable label `v'
ren `v' value`vlabel'
}
ren A WEOCountryCode
reshape long value, i(WEOCountryCode SubjectDescriptor) j(Year)
reshape wide value, i(WEOCountryCode Year) j(SubjectDescriptor) string
ren values s
ren valuei i
ren WEOCountryCode WEO_Code
merge 1:1 WEO_Code Year using weo1, nogen keep(3)

//make sure after reshaping, the saving variable is named as s, and the investment variable is named as i

* Q3. Please order the database with the following sequence: id WEO_Code Country Year gdp xm ur pop i s; then sort by id
order id WEO_Code Country Year gdp xm ur pop i s
sort id

* Q4. Please keep the obs between year 1995 and 2026
keep if inrange(Year, 1995, 2016)

************************************
** Part 2. Panel Analysis
************************************

* Q5. Please use panel command (xtset) to create a variable which is the percentage change of GDP on an annual basis for each country
xtset WEO_Code Year, yearly
gen pc_gdp = d.gdp/gdp*100

* Q6. Please use panel command (xtset) to create variables which is the percentage change of Population, Savings, and Investment on an annual basis for each country
gen pc_pop = d.pop/pop*100
gen pc_s = d.s/s*100
gen pc_i = d.i/i*100


************************************
** Part 3. Regression and Forecast
************************************

/*
* Q7. Please run a series of multivariate fixed effect regressions using 2000 to 2018 data only: 
(1) percent change in gdp on percent change in population, controling for percent change in saving
(2) percent change in gdp on percent change in population, controling for percent change in investment
(3) percent change in gdp on percent change in population, controling for both percent changes in saving and investment
*/

keep if inrange(Year, 2000, 2018)
xtreg pc_gdp pc_pop pc_s, fe
xtreg pc_gdp pc_pop pc_i, fe
xtreg pc_gdp pc_pop pc_s pc_i, fe

* Q8. Please export the regression results to a .xls file, then copy the results to the "EXAM02 ..." workbook, sheet "Report" columns A:D.
// outreg2 is recommended here
xtreg pc_gdp pc_pop pc_s, fe
outreg2 using results.xls, ctitle("Model 1") auto(3) label pval replace
xtreg pc_gdp pc_pop pc_i, fe
outreg2 using results.xls, ctitle("Model 2") auto(3) label pval append
xtreg pc_gdp pc_pop pc_s pc_i, fe
outreg2 using results.xls, ctitle("Model 3") auto(3) label pval append

* Q9. Please predict two post-estimation indicators: the fitted value (xb) and the fixed effect (u) for the third model
predict xb, xb
predict u, u


/**********************/
/*Clean and set memory*/
/**********************/
clear all
set matsize 5000
set more off

/******************/
/*Install programs*/
/******************/
cap ssc install xtabond2 
cap ssc install xtivreg2 
cap ssc install spmat 
cap ssc install spmack

/*********************/
/*Sets base directory*/
/*********************/
global project "/bbkinghome/pascual/winprofile/mydocs/replication_files_ddcg/"  /* Set base directory                         */

/****************************/
/*Create anxillary variables*/
/****************************/

use "$project/DDCGdata_final.dta"

/* Identifies transitions */
gen tdemoc=.
replace tdemoc=1 if dem==1&l.dem==0
replace tdemoc=0 if dem==0&l.dem==0  

/* Defines lags of GDP */
gen lag1y=l1.y
gen lag2y=l2.y
gen lag3y=l3.y
gen lag4y=l4.y                       

/* Drop observations with no data to estimate probit */
keep if lag1y!=. 
keep if lag2y!=.
keep if lag3y!=.
keep if lag4y!=.
                 
/* Creates lags of GDP */
gen ydep0=L15.y-L.y
gen ydep1=L14.y-L.y
gen ydep2=L13.y-L.y
gen ydep3=L12.y-L.y
gen ydep4=L11.y-L.y
gen ydep5=L10.y-L.y
gen ydep6=L9.y-L.y
gen ydep7=L8.y-L.y
gen ydep8=L7.y-L.y
gen ydep9=L6.y-L.y
gen ydep10=L5.y-L.y
gen ydep11=L4.y-L.y
gen ydep12=L3.y-L.y
gen ydep13=L2.y-L.y
gen ydep14=0                        

/* Creates leads of GDP */
gen ydep15=y-L.y
gen ydep16=F1.y-L.y
gen ydep17=F2.y-L.y
gen ydep18=F3.y-L.y
gen ydep19=F4.y-L.y
gen ydep20=F5.y-L.y
gen ydep21=F6.y-L.y
gen ydep22=F7.y-L.y
gen ydep23=F8.y-L.y
gen ydep24=F9.y-L.y
gen ydep25=F10.y-L.y
gen ydep26=F11.y-L.y
gen ydep27=F12.y-L.y
gen ydep28=F13.y-L.y
gen ydep29=F14.y-L.y
gen ydep30=F15.y-L.y
gen ydep31=F16.y-L.y
gen ydep32=F17.y-L.y
gen ydep33=F18.y-L.y
gen ydep34=F19.y-L.y
gen ydep35=F20.y-L.y
gen ydep36=F21.y-L.y
gen ydep37=F22.y-L.y
gen ydep38=F23.y-L.y
gen ydep39=F24.y-L.y
gen ydep40=F25.y-L.y
gen ydep41=F26.y-L.y
gen ydep42=F27.y-L.y
gen ydep43=F28.y-L.y
gen ydep44=F29.y-L.y
gen ydep45=F30.y-L.y                 

/* Define sample */
keep if tdemoc!=.	

/*******************************************************************************************************************************/
/*******************************************************************************************************************************/
/*********************DEFINE PROGRAM THAT COMPUTES THE REGRESSION ADJUSTMENT ESTIMATOR FOR ALL YEARS  **************************/
/*******************************************************************************************************************************/
/*******************************************************************************************************************************/
capture program tefpas_ra, eclass

/* Create year dummies and avoids using ones with no observation (program teffects gets stuck with variables it should drop) */
quietly: tab year if ydep0!=. & tdemoc!=., gen(dumyears)

/* Estimates for year -15 */
cap: teffects ra (ydep0 dumyears*, noconstant) (tdemoc), atet iterate(7)

/* Save the results */
if _rc==0{
matrix b=_b[ATET: r1vs0.tdemoc]
}
else{
matrix b=(.)
}
quietly: drop dumyears*

/* Estimates for years -14 to -2 */
forvalues s=1(1)13{

/* Create year dummies and avoids using ones with no observation (program teffects gets stuck with variables it should drop) */
quietly: tab year if ydep`s'!=. & tdemoc!=., gen(dumyears)

/* Estimates for year s */
cap: teffects ra (ydep`s' dumyears*, noconstant) (tdemoc), atet iterate(7)

/* Save the results */
if _rc==0{
matrix b=(b, _b[ATET: r1vs0.tdemoc])
}
else{
matrix b=(b, .)
}
quietly: drop dumyears*
}

/* Estimates for year -1 are zero by construction */
matrix b=(b, 0)

/* Estimates for years 0 to 30 */
forvalues s=15(1)45{

/* Create year dummies and avoids using ones with no observation (program teffects gets stuck with variables it should drop) */
quietly: tab year if ydep`s'!=. & tdemoc!=., gen(dumyears)

/* Estimates for year s */
cap: teffects ra (ydep`s' dumyears*, noconstant) (tdemoc), atet iterate(7)

/* Save the results */
if _rc==0{
matrix b=(b, _b[ATET: r1vs0.tdemoc])
}
else{
matrix b=(b, .)
}
quietly: drop dumyears*
}

/* Post results in matrix b, variance computed by bootstrapping later */
ereturn post b
end

/* Estimates */
tefpas_ra 
preserve
clear
set obs 46
gen estimate=.
gen time=.
forvalues j=1(1)46{
replace estimate = _b[c`j'] in `j'
replace time=`j'-16 in `j'
}
tsset time

/* Exports figure */
twoway (tsline estimate, lcolor(black) lpattern(solid)) ///
       , ytitle("Change in GDP per capita log points") xtitle(Years around democratization) legend(off) ///
	   graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white)) plotregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white)) ///
	   xlabel(-15(5)30) ylabel(-5(5)27)
graph export "$project/results/FigureDip.eps", as(eps) preview(off) replace /*Plots and saves figure 1*/

restore






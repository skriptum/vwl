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
local  repsBS=100                                                                           /* Number of bootstrap repetitions            */

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

/* Set seed */				 
set seed 12345                       

/*******************************************************************************************************************************/
/*******************************************************************************************************************************/
/*********************DEFINE PROGRAM THAT COMPUTES THE REGRESSION ADJUSTMENT ESTIMATOR FOR ALL YEARS  **************************/
/*******************************************************************************************************************************/
/*******************************************************************************************************************************/
capture program tefpas_ra, eclass

/* Create year dummies and avoids using ones with no observation (program teffects gets stuck with variables it should drop) */
quietly: tab year if ydep0!=. & tdemoc!=., gen(dumyears)

/* Estimates for year -15 */
cap: teffects ra (ydep0 lag1y lag2y lag3y lag4y dumyears*, noconstant) (tdemoc), atet iterate(7)

/* Save the results */
if _rc==0{
matrix b=_b[ATET: r1vs0.tdemoc]
}
else{
matrix b=(.)
}
quietly: drop dumyears*

/* Estimates for years -14 to -5 */
forvalues s=1(1)10{

/* Create year dummies and avoids using ones with no observation (program teffects gets stuck with variables it should drop) */
quietly: tab year if ydep`s'!=. & tdemoc!=., gen(dumyears)

/* Estimates for year s */
cap: teffects ra (ydep`s' lag1y lag2y lag3y lag4y dumyears*, noconstant) (tdemoc), atet iterate(7)

/* Save the results */
if _rc==0{
matrix b=(b, _b[ATET: r1vs0.tdemoc])
}
else{
matrix b=(b, .)
}
quietly: drop dumyears*
}

/* Estimates for years -4, -3, -2, -1 are zero by construction */
matrix b=(b, 0)
matrix b=(b, 0)
matrix b=(b, 0)
matrix b=(b, 0)

/* Estimates for years 0 to 30 */
forvalues s=15(1)45{

/* Create year dummies and avoids using ones with no observation (program teffects gets stuck with variables it should drop) */
quietly: tab year if ydep`s'!=. & tdemoc!=., gen(dumyears)

/* Estimates for year s */
cap: teffects ra (ydep`s' lag1y lag2y lag3y lag4y dumyears*, noconstant) (tdemoc), atet iterate(7)

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

/*******************************************************************************************************************************/
/*******************************************************************************************************************************/
/************ DEFINE PROGRAM THAT COMPUTES THE INVERSE PROPENSITY SCORE REWEIGHTING ESTIMATOR FOR ALL YEARS ********************/
/*******************************************************************************************************************************/
/*******************************************************************************************************************************/
capture program tefpas_ipw, eclass

/* Create year dummies and avoids using ones with no observation (program teffects gets stuck with variables it should drop) */
quietly: gen temp=tdemoc if ydep0!=. &tdemoc!=.
quietly: bysort year: egen mtemp=max(temp)
quietly: tab year if mtemp==1, gen(dumyears)

/* Estimates for year -15 */
cap: teffects ipw (ydep0) (tdemoc lag1y lag2y lag3y lag4y dumyears*, noconstant probit), atet iterate(7)

/* Save the results */
if _rc==0{
matrix b=_b[ATET: r1vs0.tdemoc]
}
else{
matrix b=(.)
}

quietly: drop dumyears* temp mtemp

/* Estimates for year -14 to -2*/
forvalues s=1(1)13{

/* Create year dummies and avoids using ones with no observation (program teffects gets stuck with variables it should drop) */
quietly: gen temp=tdemoc if ydep`s'!=. &tdemoc!=.
quietly: bysort year: egen mtemp=max(temp)
quietly: tab year if mtemp==1, gen(dumyears)

cap: teffects ipw (ydep`s') (tdemoc lag1y lag2y lag3y lag4y dumyears*, noconstant probit), atet iterate(7)

/* Save the results */
if _rc==0{
matrix b=(b, _b[ATET: r1vs0.tdemoc])
}
else{
matrix b=(b, .)
}
quietly: drop dumyears* temp mtemp
}

/* Estimates for year -1 is zero by construction */
matrix b=(b, 0)

/* Estimates for year 0 to 30 */
forvalues s=15(1)45{

/* Create year dummies and avoids using ones with no observation (program teffects gets stuck with variables it should drop) */
quietly: gen temp=tdemoc if ydep`s'!=. &tdemoc!=.
quietly: bysort year: egen mtemp=max(temp)
quietly: tab year if mtemp==1, gen(dumyears)

cap: teffects ipw (ydep`s') (tdemoc lag1y lag2y lag3y lag4y dumyears*, noconstant probit), atet iterate(7)

/* Save the results */
if _rc==0{
matrix b=(b, _b[ATET: r1vs0.tdemoc])
}
else{
matrix b=(b, .)
}
quietly: drop dumyears* temp mtemp
}

/* Post results in matrix b, variance computed by bootstrapping later */
ereturn post b
end

/*******************************************************************************************************************************/
/*******************************************************************************************************************************/
/************************ DEFINE PROGRAM THAT COMPUTES THE DOUBLY ROBUST ESTIMATOR FOR ALL YEARS *******************************/
/*******************************************************************************************************************************/
/*******************************************************************************************************************************/
capture program tefpas_ipwra, eclass

/* Create year dummies and avoids using ones with no observation (program teffects gets stuck with variables it should drop) */
quietly: gen temp=tdemoc if ydep0!=. &tdemoc!=.
quietly: bysort year: egen mtemp=max(temp)
quietly: tab year if mtemp==1, gen(dumyears)

cap: teffects ipwra (ydep0 lag1y lag2y lag3y lag4y dumyears*, noconstant) (tdemoc lag1y lag2y lag3y lag4y dumyears*, probit), atet iterate(7)

/* Save the results */
if _rc==0{
matrix b=_b[ATET: r1vs0.tdemoc]
}
else{
matrix b=(.)
}
quietly: drop dumyears* temp mtemp

/* Estimates for years -14 to -5 */
forvalues s=1(1)10{

/* Create year dummies and avoids using ones with no observation (program teffects gets stuck with variables it should drop) */
quietly: gen temp=tdemoc if ydep`s'!=. &tdemoc!=.
quietly: bysort year: egen mtemp=max(temp)
quietly: tab year if mtemp==1, gen(dumyears)

cap: teffects ipwra (ydep`s' lag1y lag2y lag3y lag4y dumyears*, noconstant) (tdemoc lag1y lag2y lag3y lag4y dumyears*, probit), atet iterate(7)

/* Save the results */
if _rc==0{
matrix b=(b, _b[ATET: r1vs0.tdemoc])
}
else{
matrix b=(b, .)
}
quietly: drop dumyears* temp mtemp
}

/* Estimates for years -4, -3, -2, -1 are zero by construction */
matrix b=(b, 0)
matrix b=(b, 0)
matrix b=(b, 0)
matrix b=(b, 0)

/* Estimates for year 0 to 30 */
forvalues s=15(1)45{

/* Create year dummies and avoids using ones with no observation (program teffects gets stuck with variables it should drop) */
quietly: gen temp=tdemoc if ydep`s'!=. &tdemoc!=.
quietly: bysort year: egen mtemp=max(temp)
quietly: tab year if mtemp==1, gen(dumyears)

cap: teffects ipwra (ydep`s' lag1y lag2y lag3y lag4y dumyears*, noconstant) (tdemoc lag1y lag2y lag3y lag4y dumyears*, probit), atet iterate(7)

/* Save the results */
if _rc==0{
matrix b=(b, _b[ATET: r1vs0.tdemoc])
}
else{
matrix b=(b, .)
}
quietly: drop dumyears* temp mtemp
}

/* Post results in matrix b, variance computed by bootstrapping later */
ereturn post b
end

/*******************************************************************************************************************************/
/*******************************************************************************************************************************/
/************************************ ESTIMATION PROCEDURES AND STORING RESULTS ************************************************/
/*******************************************************************************************************************************/
/*******************************************************************************************************************************/

/* 1. Bootstrap and save results, these are also used to construct figures later */
xtset, clear
bootstrap _b, reps(`repsBS') cluster(wbcode2): tefpas_ra 
parmest, format(estimate min95 max95) saving("$project/results/impulse_ra_alt", replace)

/* Results, 5-1 years before transition */
estimates store e0
nlcom (effect0: (_b[c11]+_b[c12]+_b[c13]+_b[c14]+_b[c15])/5), post
estimates store e1
/* Results, 1-5 years after transition */
estimates restore e0
nlcom (effect0: (_b[c16]+_b[c17]+_b[c18]+_b[c19]+_b[c20])/5), post
estimates store e2
/* Results, 6-10 years after transition */
estimates restore e0
nlcom (effect0: (_b[c21]+_b[c22]+_b[c23]+_b[c24]+_b[c25])/5), post
estimates store e3
/* Results, 11-15 years after transition */
estimates restore e0
nlcom (effect0: (_b[c26]+_b[c27]+_b[c28]+_b[c29]+_b[c30])/5), post
estimates store e4
/* Results, 16-20 years after transition */
estimates restore e0
nlcom (effect0: (_b[c31]+_b[c32]+_b[c33]+_b[c34]+_b[c35])/5), post
estimates store e5
/* Results, 21-25 years after transition */
estimates restore e0
nlcom (effect0: (_b[c36]+_b[c37]+_b[c38]+_b[c39]+_b[c40])/5), post
estimates store e6
/* Results, 26-30 years after transition */
estimates restore e0
nlcom (effect0: (_b[c41]+_b[c42]+_b[c43]+_b[c44]+_b[c45])/5), post
estimates store e7

/* Export table with results to latex */
#delimit ;
estout e1 e2 e3 e4 e5 e6 e7  using "$project/results/TableNonPar_RA_alt.tex", style(tex) 
varlabels(effect0 "Average effect of democracy on log GDP") 
cells(b(star fmt(%9.3f)) se(par)) 
keep(effect0) 
order(effect0)
stardrop(effect0)  
nolabel replace mlabels(none) collabels(none); 
#delimit cr


/* 2. Bootstrap and save results, these are also used to construct figures later */ 
xtset, clear
bootstrap _b, reps(`repsBS') cluster(wbcode2): tefpas_ipw
parmest, format(estimate min95 max95) saving("$project/results/impulse_ipw_alt", replace)

/* Results, 5-1 years before transition */
estimates store e0
nlcom (effect0: (_b[c11]+_b[c12]+_b[c13]+_b[c14]+_b[c15])/5), post
estimates store e1
/* Results, 1-5 years after transition */
estimates restore e0
nlcom (effect0: (_b[c16]+_b[c17]+_b[c18]+_b[c19]+_b[c20])/5), post
estimates store e2
/* Results, 6-10 years after transition */
estimates restore e0
nlcom (effect0: (_b[c21]+_b[c22]+_b[c23]+_b[c24]+_b[c25])/5), post
estimates store e3
/* Results, 11-15 years after transition */
estimates restore e0
nlcom (effect0: (_b[c26]+_b[c27]+_b[c28]+_b[c29]+_b[c30])/5), post
estimates store e4
/* Results, 16-20 years after transition */
estimates restore e0
nlcom (effect0: (_b[c31]+_b[c32]+_b[c33]+_b[c34]+_b[c35])/5), post
estimates store e5
/* Results, 21-25 years after transition */
estimates restore e0
nlcom (effect0: (_b[c36]+_b[c37]+_b[c38]+_b[c39]+_b[c40])/5), post
estimates store e6
/* Results, 26-30 years after transition */
estimates restore e0
nlcom (effect0: (_b[c41]+_b[c42]+_b[c43]+_b[c44]+_b[c45])/5), post
estimates store e7

/* Export table with results to latex */
#delimit ;
estout e1 e2 e3 e4 e5 e6 e7  using "$project/results/TableNonPar_IPW_alt.tex", style(tex) 
varlabels(effect0 "Average effect of democracy on log GDP") 
cells(b(star fmt(%9.3f)) se(par)) 
keep(effect0) 
order(effect0)
stardrop(effect0)  
nolabel replace mlabels(none) collabels(none); 
#delimit cr


/* 3. Bootstrap and save results, these are also used to construct figures later */ 
xtset, clear
bootstrap _b, reps(`repsBS') cluster(wbcode2): tefpas_ipwra
parmest, format(estimate min95 max95) saving("$project/results/impulse_ipwra_alt", replace)

/* Results, 5-1 years before transition */
estimates store e0
nlcom (effect0: (_b[c11]+_b[c12]+_b[c13]+_b[c14]+_b[c15])/5), post
estimates store e1
/* Results, 1-5 years after transition */
estimates restore e0
nlcom (effect0: (_b[c16]+_b[c17]+_b[c18]+_b[c19]+_b[c20])/5), post
estimates store e2
/* Results, 6-10 years after transition */
estimates restore e0
nlcom (effect0: (_b[c21]+_b[c22]+_b[c23]+_b[c24]+_b[c25])/5), post
estimates store e3
/* Results, 11-15 years after transition */
estimates restore e0
nlcom (effect0: (_b[c26]+_b[c27]+_b[c28]+_b[c29]+_b[c30])/5), post
estimates store e4
/* Results, 16-20 years after transition */
estimates restore e0
nlcom (effect0: (_b[c31]+_b[c32]+_b[c33]+_b[c34]+_b[c35])/5), post
estimates store e5
/* Results, 21-25 years after transition */
estimates restore e0
nlcom (effect0: (_b[c36]+_b[c37]+_b[c38]+_b[c39]+_b[c40])/5), post
estimates store e6
/* Results, 26-30 years after transition */
estimates restore e0
nlcom (effect0: (_b[c41]+_b[c42]+_b[c43]+_b[c44]+_b[c45])/5), post
estimates store e7

/* Export table with results to latex */
#delimit ;
estout e1 e2 e3 e4 e5 e6 e7  using "$project/results/TableNonPar_IPWRA_alt.tex", style(tex) 
varlabels(effect0 "Average effect of democracy on log GDP") 
cells(b(star fmt(%9.3f)) se(par)) 
keep(effect0) 
order(effect0)
stardrop(effect0)  
nolabel replace mlabels(none) collabels(none); 
#delimit cr

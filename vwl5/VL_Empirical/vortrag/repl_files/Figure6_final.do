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
/***Democratization waves****/
/****************************/

use "$project/DDCGdata_final.dta", clear

/*Identify first transition to democracy in each region*/
sort wbcode2 year
replace yeardem=0 if l.dem==.|l2.dem==.|l3.dem==.|l4.dem==.|l5.dem==. /*Remove periods of democracy in first years that are not taken into account and are used to define intiial regimes*/
replace dem=0 if (l.dem==.|l2.dem==.|l3.dem==.|l4.dem==.|l5.dem==.|l6.dem==.)&InitReg==0 /*Remove changes in democracy among countries that had a short lived democracy period after independence */
gen temp=.
replace temp=year if InitReg==0 & yeardem==1
bysort region demext: egen ydem=min(temp)

/*remove first democratizer to avoid mechanical relations*/
gen tag=.
replace tag=1 if year==ydem&yeardem==1
bysort wbcode: egen tag2=mean(tag)
gen tempp=wbcode2 if tag2==1
bysort region demext: egen temp2=min(tempp)
drop if tag2==1&temp2==wbcode2

/* Keep region times initial regime cells that were initially autocratic and collapse data*/
keep if demext=="_nd"
collapse ydem dem, by(region demext year)

/*Remove global trends*/
gen dhat1=.
gen temp=dem if region!="AFR"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="AFR"
drop temp temp2

gen temp=dem if region!="EAP"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="EAP"
drop temp temp2

gen temp=dem if region!="ECA"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="ECA"
drop temp temp2

gen temp=dem if region!="INL"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="INL"
drop temp temp2

gen temp=dem if region!="LAC"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="LAC"
drop temp temp2

gen temp=dem if region!="MNA"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="MNA"
drop temp temp2

gen temp=dem if region!="SAS"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="SAS"
drop temp temp2

/* Recenter the data around first democratization*/
gen time=year-ydem 
keep if time!=.

/* Collapse at the yearly level and plot */
collapse dhat1 dem, by(time)
rename time year
sort year
tsset year
keep if year>=-10&year<=20

/* Plots figure */
twoway (tsline dhat1, lcolor(gs5) lpattern(longdash)) (tsline dem, lcolor(black) lpattern(solid)), ytitle(Mean democracy) xtitle(Years around first democratization in the region) legend(on order(2 "Initial nondemocracies in the region" 1 "Initial nondemocracies in other regions" ) cols(1)) graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white)) plotregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))  xlabel(-10(5)20)
graph export "$project/results/FigureFS.eps", as(eps) preview(off) replace


/****************************/
/***Democratization waves****/
/****************************/

use "$project/DDCGdata_final.dta", clear

/*Identify first transition to democracy in each region*/
sort wbcode2 year
replace yearrev=0 if l.dem==.|l2.dem==.|l3.dem==.|l4.dem==.|l5.dem==. /*Remove periods of democracy in first years that are not taken into account and are used to define intiial regimes*/
gen temp=.
replace temp=year if InitReg==1 & yearrev==1
bysort region demext: egen ydem=min(temp)

/*remove first democratizer to avoid mechanical relations*/
gen tag=.
replace tag=1 if year==ydem&yearrev==1
bysort wbcode: egen tag2=mean(tag)
gen tempp=wbcode2 if tag2==1
bysort region demext: egen temp2=min(tempp)
drop if tag2==1&temp2==wbcode2

/* Keep region times initial regime cells that were initially autocratic and collapse data*/
keep if demext=="_dem"
collapse ydem dem, by(region demext year)

/*Remove global trends*/
gen dhat1=.
gen temp=dem if region!="AFR"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="AFR"
drop temp temp2

gen temp=dem if region!="EAP"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="EAP"
drop temp temp2

gen temp=dem if region!="ECA"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="ECA"
drop temp temp2

gen temp=dem if region!="INL"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="INL"
drop temp temp2

gen temp=dem if region!="LAC"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="LAC"
drop temp temp2

gen temp=dem if region!="MNA"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="MNA"
drop temp temp2

gen temp=dem if region!="SAS"
bysort year: egen temp2=mean(temp)
replace dhat1=temp2 if region=="SAS"
drop temp temp2

/* Recenter the data around first democratization*/
gen time=year-ydem 
keep if time!=.

/* Collapse at the yearly level and plot */
collapse dhat1 dem, by(time)
rename time year
sort year
tsset year
keep if year>=-10&year<=20

/* Plots figure */
twoway (tsline dhat1, lcolor(gs5) lpattern(longdash)) (tsline dem, lcolor(black) lpattern(solid)), ytitle(Mean democracy) xtitle(Years around first reversal in the region) legend(on order(2 "Initial democracies in the region" 1 "Initial democracies in other regions" ) cols(1)) graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white)) plotregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))  xlabel(-10(5)20)
graph export "$project/results/FigureFSRev.eps", as(eps) preview(off) replace

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
global limit=25                                                                             /* Evaluate effects 25 years after transition */
local repsBS=100                                                                            /* Number of bootstrap repetitions            */

/*******************************************************************************************************************************/
/*******************************************************************************************************************************/
/*********************DEFINE REQUIRED PROGRAMS THAT WILL BE USED DURING THE EXECUTION OF THIS DO FILE **************************/
/*******************************************************************************************************************************/
/*******************************************************************************************************************************/
capture program drop vareffects
program define vareffects, eclass

quietly: nlcom (effect1: _b[shortrun]) ///
	  (shortrun: _b[shortrun]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  , post

quietly: nlcom (effect2: _b[effect1]*_b[lag1]+_b[shortrun]) ///
	  (effect1: _b[effect1]) ///
	  (shortrun: _b[shortrun]) ///
	  (level: _b[effect1]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  , post

quietly: nlcom (effect3: _b[effect2]*_b[lag1]+_b[effect1]*_b[lag2]+_b[shortrun]) ///
	  (effect2: _b[effect2]) ///
	  (effect1: _b[effect1]) ///
	  (shortrun: _b[shortrun]) ///
	  (level: _b[level]+_b[effect2]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  , post
	  
quietly: nlcom (effect4: _b[effect3]*_b[lag1]+_b[effect2]*_b[lag2]+_b[effect1]*_b[lag3]+_b[shortrun]) ///
	  (effect3: _b[effect3]) ///
	  (effect2: _b[effect2]) ///
	  (effect1: _b[effect1]) ///
	  (shortrun: _b[shortrun]) ///
	  (level: _b[level]+_b[effect3]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  , post	  

forvalues j=5(1)$limit{	  
local j1=`j'-1
local j2=`j'-2
local j3=`j'-3
local j4=`j'-4

quietly: nlcom (effect`j': _b[effect`j1']*_b[lag1]+_b[effect`j2']*_b[lag2]+_b[effect`j3']*_b[lag3]+_b[effect`j4']*_b[lag4]+_b[shortrun]) ///
	  (effect`j1': _b[effect`j1']) ///
	  (effect`j2': _b[effect`j2']) ///
	  (effect`j3': _b[effect`j3']) ///
	  (shortrun: _b[shortrun]) ///
	  (level: _b[level]+_b[effect`j1']) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  , post	  	  

}

quietly: nlcom (effect$limit: _b[effect$limit]) ///
	  (longrun: _b[shortrun]/(1-_b[lag1]-_b[lag2]-_b[lag3]-_b[lag4])) ///
      (shortrun: _b[shortrun]) ///
	  (persistence: _b[lag1]+_b[lag2]+_b[lag3]+_b[lag4]) ///
	  (level: _b[level]+_b[effect$limit]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  , post
ereturn display
end

capture program drop vareffects8
program define vareffects8, eclass

quietly: nlcom (effect1: _b[shortrun]) ///
	  (shortrun: _b[shortrun]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  (lag5: _b[lag5]) ///
	  (lag6: _b[lag6]) ///
	  (lag7: _b[lag7]) ///
	  (lag8: _b[lag8]) ///
	  , post

quietly: nlcom (effect2: _b[effect1]*_b[lag1]+_b[shortrun]) ///
	  (effect1: _b[effect1]) ///
	  (shortrun: _b[shortrun]) ///
	  (level: _b[effect1]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  (lag5: _b[lag5]) ///
	  (lag6: _b[lag6]) ///
	  (lag7: _b[lag7]) ///
	  (lag8: _b[lag8]) ///
	  , post

quietly: nlcom (effect3: _b[effect2]*_b[lag1]+_b[effect1]*_b[lag2]+_b[shortrun]) ///
	  (effect2: _b[effect2]) ///
	  (effect1: _b[effect1]) ///
	  (shortrun: _b[shortrun]) ///
	  (level: _b[level]+_b[effect2]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  (lag5: _b[lag5]) ///
	  (lag6: _b[lag6]) ///
	  (lag7: _b[lag7]) ///
	  (lag8: _b[lag8]) ///
	  , post
	  
quietly: nlcom (effect4: _b[effect3]*_b[lag1]+_b[effect2]*_b[lag2]+_b[effect1]*_b[lag3]+_b[shortrun]) ///
	  (effect3: _b[effect3]) ///
	  (effect2: _b[effect2]) ///
	  (effect1: _b[effect1]) ///
	  (shortrun: _b[shortrun]) ///
	  (level: _b[level]+_b[effect3]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  (lag5: _b[lag5]) ///
	  (lag6: _b[lag6]) ///
	  (lag7: _b[lag7]) ///
	  (lag8: _b[lag8]) ///
	  , post
	  
quietly: nlcom (effect5: _b[effect4]*_b[lag1]+_b[effect3]*_b[lag2]+_b[effect2]*_b[lag3]+_b[effect1]*_b[lag4]+_b[shortrun]) ///
	  (effect4: _b[effect4]) ///
	  (effect3: _b[effect3]) ///
	  (effect2: _b[effect2]) ///
	  (effect1: _b[effect1]) ///
	  (shortrun: _b[shortrun]) ///
	  (level: _b[level]+_b[effect4]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  (lag5: _b[lag5]) ///
	  (lag6: _b[lag6]) ///
	  (lag7: _b[lag7]) ///
	  (lag8: _b[lag8]) ///
	  , post
	  
quietly: nlcom (effect6: _b[effect5]*_b[lag1]+_b[effect4]*_b[lag2]+_b[effect3]*_b[lag3]+_b[effect2]*_b[lag4]+_b[effect1]*_b[lag5]+_b[shortrun]) ///
	  (effect5: _b[effect5]) ///
	  (effect4: _b[effect4]) ///
	  (effect3: _b[effect3]) ///
	  (effect2: _b[effect2]) ///
	  (effect1: _b[effect1]) ///
	  (shortrun: _b[shortrun]) ///
	  (level: _b[level]+_b[effect5]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  (lag5: _b[lag5]) ///
	  (lag6: _b[lag6]) ///
	  (lag7: _b[lag7]) ///
	  (lag8: _b[lag8]) ///
	  , post	  
	  
quietly: nlcom (effect7: _b[effect6]*_b[lag1]+_b[effect5]*_b[lag2]+_b[effect4]*_b[lag3]+_b[effect3]*_b[lag4]+_b[effect2]*_b[lag5]+_b[effect1]*_b[lag6]+_b[shortrun]) ///
	  (effect6: _b[effect6]) ///
	  (effect5: _b[effect5]) ///
	  (effect4: _b[effect4]) ///
	  (effect3: _b[effect3]) ///
	  (effect2: _b[effect2]) ///
	  (effect1: _b[effect1]) ///
	  (shortrun: _b[shortrun]) ///
	  (level: _b[level]+_b[effect6]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  (lag5: _b[lag5]) ///
	  (lag6: _b[lag6]) ///
	  (lag7: _b[lag7]) ///
	  (lag8: _b[lag8]) ///
	  , post	
	  
quietly: nlcom (effect8: _b[effect7]*_b[lag1]+_b[effect6]*_b[lag2]+_b[effect5]*_b[lag3]+_b[effect4]*_b[lag4]+_b[effect3]*_b[lag5]+_b[effect2]*_b[lag6]+_b[effect1]*_b[lag7]+_b[shortrun]) ///
	  (effect7: _b[effect7]) ///
	  (effect6: _b[effect6]) ///
	  (effect5: _b[effect5]) ///
	  (effect4: _b[effect4]) ///
	  (effect3: _b[effect3]) ///
	  (effect2: _b[effect2]) ///
	  (effect1: _b[effect1]) ///
	  (shortrun: _b[shortrun]) ///
	  (level: _b[level]+_b[effect7]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  (lag5: _b[lag5]) ///
	  (lag6: _b[lag6]) ///
	  (lag7: _b[lag7]) ///
	  (lag8: _b[lag8]) ///
	  , post		  
	  
	  
forvalues j=9(1)$limit{	  
local j1=`j'-1
local j2=`j'-2
local j3=`j'-3
local j4=`j'-4
local j5=`j'-5
local j6=`j'-6
local j7=`j'-7
local j8=`j'-8

quietly: nlcom (effect`j': _b[effect`j1']*_b[lag1]+_b[effect`j2']*_b[lag2]+_b[effect`j3']*_b[lag3]+_b[effect`j4']*_b[lag4]+_b[effect`j5']*_b[lag5]+_b[effect`j6']*_b[lag6]+_b[effect`j7']*_b[lag7]+_b[effect`j8']*_b[lag8]+_b[shortrun]) ///
	  (effect`j1': _b[effect`j1']) ///
	  (effect`j2': _b[effect`j2']) ///
	  (effect`j3': _b[effect`j3']) ///
	  (effect`j4': _b[effect`j4']) ///
	  (effect`j5': _b[effect`j5']) ///
	  (effect`j6': _b[effect`j6']) ///
	  (effect`j7': _b[effect`j7']) ///
	  (shortrun: _b[shortrun]) ///
	  (level: _b[level]+_b[effect`j1']) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  (lag5: _b[lag5]) ///
	  (lag6: _b[lag6]) ///
	  (lag7: _b[lag7]) ///
	  (lag8: _b[lag8]) ///
	  , post	  	  

}

quietly: nlcom (effect$limit: _b[effect$limit]) ///
	  (longrun: _b[shortrun]/(1-_b[lag1]-_b[lag2]-_b[lag3]-_b[lag4])) ///
      (shortrun: _b[shortrun]) ///
	  (persistence: _b[lag1]+_b[lag2]+_b[lag3]+_b[lag4]) ///
	  (level: _b[level]+_b[effect$limit]) ///
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  (lag5: _b[lag5]) ///
	  (lag6: _b[lag6]) ///
	  (lag7: _b[lag7]) ///
	  (lag8: _b[lag8]) ///
	  , post
ereturn display
end


capture program drop helm
program define helm
*
* This program will do Helmert transformation for a list of variables
* NOTE:  must have variables named id, year   
* to use enter >> helm var1 var2...
* new variables will be names with h_ in front h_var1  and so on
*
qui while "`1'"~="" {
gsort id -year                /*sort years descending */
tempvar one sum n m w 
* capture drop h_`1'         /* IF the variable exist - it will remain and not generated again */
gen `one'=1 if `1'~=.             /*generate one if x is nonmissing */
qui by id: gen `sum'=sum(`1')-`1' /*running sum without current element */
qui by id: gen `n'=sum(`one')-1     /*number of obs included in the sum */
replace `n'=. if `n'<=0             /* n=0 for last observation and =-1 if
                                   last observation is missing*/
gen `m'=`sum'/`n'                 /* m is forward mean of variable x*/
gen `w'=sqrt(`n'/(`n'+1))         /* weight on mean difference */
capture gen h_`1'=`w'*(`1'-`m')             /* transformed variable */ 
sort id year
mac shift
}
end




capture program hhkBS, eclass
syntax anything[, ydeep(integer 1960) ystart(integer 1964) yfinal(integer 2009) truncate(integer 4) depvarlags(integer 4)]
	local 0 `anything' 
	gettoken yvar 0 : 0 /*dependent variable*/
	gettoken seqexg   0 : 0, match(par) /*Sequentially exogenous variables*/
	gettoken gmminst  0 : 0, match(par) /*gmm style instruments*/
	gettoken gmmtrunc 0 : 0, match(par) /*gmm style instruments, truncated*/
	gettoken excov 0 : 0, match(par) /*exogenous covariates: diff coefficient for each equation*/
		
/*declares panel structure and defines estimation sample*/
quietly: tsset, clear
quietly: tsset newcl year
sort newcl year
quietly: xtreg `yvar' `seqexg' `excov', fe
quietly: gen tsample=e(sample)

/**************************************************************************************
*********Helmert transformations and partialing out covariates************************/
quietly: gen id=newcl
sort newcl year
quietly: reg `yvar' `excov' if tsample==1
quietly: predict `yvar'_res if tsample==1, resid
quietly: helm `yvar'_res
rename h_`yvar'_res h_`yvar'
drop `yvar'_res

local num_seqexg=0
local seqexg_helm
foreach var of local seqexg{
sort newcl year
local num_seqexg=`num_seqexg'+1
quietly: gen seqexg`num_seqexg'=`var'
quietly: reg seqexg`num_seqexg' `excov' if tsample==1
quietly: predict seqexg`num_seqexg'_res if tsample==1, resid
quietly: helm seqexg`num_seqexg'_res
rename h_seqexg`num_seqexg'_res h_seqexg`num_seqexg'
local seqexg_helm `seqexg_helm' h_seqexg`num_seqexg'
drop seqexg`num_seqexg' seqexg`num_seqexg'_res
}

/***************************************************************
***************Creation of GMM instruments**********************
***************************************************************/
local gmmlist
local num_gmm=0
foreach var of local gmminst{
sort newcl year
local num_gmm=`num_gmm'+1
quietly: gen abond`num_gmm'=`var'
quietly: reg abond`num_gmm' `excov' if tsample==1
quietly: predict abond`num_gmm'_res, resid
drop abond`num_gmm' 
rename abond`num_gmm'_res abond`num_gmm'

quietly: replace abond`num_gmm'=0 if abond`num_gmm'==.
local gmmlist `gmmlist' abond`num_gmm' 

}

local gmmlist_trunc
local num_gmm_trunc=0
foreach var of local gmmtrunc{
sort newcl year
local num_gmm_trunc=`num_gmm_trunc'+1
quietly: gen abond_trunc`num_gmm_trunc'=`var'
quietly: reg abond_trunc`num_gmm_trunc' `excov' if tsample==1
quietly: predict abond_trunc`num_gmm_trunc'_res, resid
drop abond_trunc`num_gmm_trunc' 
rename abond_trunc`num_gmm_trunc'_res abond_trunc`num_gmm_trunc'
quietly: replace abond_trunc`num_gmm_trunc'=0 if abond_trunc`num_gmm_trunc'==.
local gmmlist_trunc `gmmlist_trunc' abond_trunc`num_gmm_trunc' 
}

/***************************************************************
***************Estimator  for year j between maxy and  start***/
***************************************************************/
sort newcl year

*initialize objects*
local obs=0
quietly: gen samptemp=.
matrix def Num1=J(`num_seqexg', 1, 0)
matrix def Num2=J(`num_seqexg', `num_seqexg', 0) 
matrix def Den1=J(`num_seqexg', `num_seqexg', 0) 

forvalues maxyear=`ystart'(1)`yfinal'{

local maxinst=`maxyear'-`ydeep' /*deeper gmm lags until ydeep. Warning: many of these instruments may be zero if no data*/
local maxtrunc=min(`truncate',`maxinst')
local j=`maxyear'-1960+1

*ivreg to check for collinearities and obtain degree of overidentification*
cap ivreg2 h_`yvar' (`seqexg_helm'=l(1/`maxinst').(`gmmlist') l(1/`maxtrunc').(`gmmlist_trunc'))  if year==`maxyear',   noid  noconstant

if _rc==0{
/*Runs k-class estimator*/
local lambda=1+e(sargandf)/e(N)
cap ivreg2 h_`yvar' (`seqexg_helm'=l(1/`maxinst').(`gmmlist') l(1/`maxtrunc').(`gmmlist_trunc'))  if year==`maxyear',  k(`lambda') nocollin coviv  noid noconstant

if _rc==0{
quietly: replace samptemp=e(sample) if year==`maxyear'
local mobs=e(N)
local obs=`obs'+`mobs'

/*Construct locals with restrictions*/
local restriction
local mresults
forvalues m=1(1)`num_seqexg'{
local restriction `restriction' & _b[h_seqexg`m']!=0
local mresults `mresults' (seqexg`m': _b[h_seqexg`m'])
}

/*Extracts results and weights them by the adjusted variance*/
if _rc==0   `restriction'  {
quietly: nlcom `mresults', post
matrix b=e(b)
matrix V=e(V)
cap matrix Num1=Num1+`mobs'*inv(V)*b'
cap matrix Num2=Num2+`mobs'^2*inv(V)
cap matrix Den1=Den1+`mobs'*inv(V)
}
}
}
}

/******************Compiles results and post them******************/
matrix est2top=inv(Den1)*Num1
matrix var2top=inv(Den1)*Num2*inv(Den1)
matrix b=est2top'
matrix V=var2top
mat colnames b = `seqexg' 
mat colnames V = `seqexg' 
mat rownames V = `seqexg' 
/*Countries in sample*/
quietly: bysort newcl: egen newsamp=max(samptemp)
quietly: replace newsamp=0 if newsamp!=1
/*Post estimation results*/
ereturn post b V, obs(`obs') depname("Dep var") esample(newsamp)

drop tsample samptemp id  h_`yvar' `seqexg_helm'  `gmmlist' `gmmlist_trunc' 
end


/*******************************************************************************************************************************/
/*******************************************************************************************************************************/
/************************************ ESTIMATION PROCEDURES AND STORING RESULTS ************************************************/
/*******************************************************************************************************************************/
/*******************************************************************************************************************************/

use "$project/DDCGdata_final.dta"
gen dy=d.y /* Estimates all models in growth rates */
replace y=dy


file open myfile using "$project/results/TableGRates_lags.tex", write replace /*p-value for lags 5 to 8 not reported in the table*/
file write myfile "p-value lags 5 to 8"

/*******************************
Left panel: Within estimator
*******************************/

quietly: xtreg y l.y dem yy*, fe r cluster(wbcode2)
estimates store e1
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: 0)  (lag3: 0)  (lag4: 0), post
vareffects
estimates store e1_add

quietly: xtreg y l(1/2).y dem yy*, fe r cluster(wbcode2)
estimates store e2
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: 0)  (lag4: 0), post
vareffects
estimates store e2_add

quietly: xtreg y l(1/4).y dem yy*, fe r cluster(wbcode2)
estimates store e3
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e3_add

quietly: xtreg y l(1/8).y dem yy*, fe r cluster(wbcode2)
estimates store e4
test l5.y l6.y l7.y l8.y
file write myfile "&&&& [" %7.3f (r(p)) "] "
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]) (lag5: _b[L5.y]) (lag6: _b[L6.y]) (lag7: _b[L7.y]) (lag8: _b[L8.y]), post
vareffects8
estimates store e4_add


/******************************************
Center panel: GMM estimator with all moments
******************************************/
mata: mata set matafavor speed

quietly: xtabond2 y l.y dem yy*   ,  gmmstyle(y, laglimits(2 .)) gmmstyle(dem, laglimits(1 .)) ivstyle(yy*   , p) noleveleq robust nodiffsargan
estimates store e1gmm
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: 0)  (lag3: 0)  (lag4: 0), post
vareffects
estimates store e1gmm_add

quietly: xtabond2 y l(1/2).y dem yy*   ,  gmmstyle(y, laglimits(2 .)) gmmstyle(dem, laglimits(1 .)) ivstyle(yy*   , p) noleveleq robust nodiffsargan
estimates store e2gmm
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: 0)  (lag4: 0), post
vareffects
estimates store e2gmm_add

quietly: xtabond2 y l(1/4).y dem yy* ,  gmmstyle(y, laglimits(2 .)) gmmstyle(dem, laglimits(1 .)) ivstyle(yy*, p) noleveleq robust nodiffsargan
estimates store e3gmm
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e3gmm_add

quietly: xtabond2 y l(1/8).y dem yy*   ,  gmmstyle(y, laglimits(2 .)) gmmstyle(dem, laglimits(1 .)) ivstyle(yy*   , p) noleveleq robust nodiffsargan
estimates store e4gmm
test l5.y l6.y l7.y l8.y
file write myfile "&&&& [" %7.3f (r(p)) "] "
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]) (lag5: _b[L5.y]) (lag6: _b[L6.y]) (lag7: _b[L7.y]) (lag8: _b[L8.y]), post
vareffects8
estimates store e4gmm_add


/******************************************
Right panel: Minimum distance estimator
******************************************/

/*****************************Model 1: one lag****************************************************/
sort wbcode2 year
gen newcl=wbcode2
tsset newcl year

bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS y (dem L1.y) (y dem) () (yy*), ydeep(1960) ystart(1961) yfinal(2009) truncate(4)
estimates store e1md
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: 0)  (lag3: 0)  (lag4: 0), post
vareffects
estimates store e1md_add

/*****************************Model 2: two lags****************************************************/
sort wbcode2 year
replace newcl=wbcode2
tsset newcl year

bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS y (dem L1.y L2.y) (y dem) () (yy*), ydeep(1960) ystart(1962) yfinal(2009) truncate(4)
estimates store e2md
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: 0)  (lag4: 0), post
vareffects
estimates store e2md_add


/*****************************Model 3: four lags****************************************************/
sort wbcode2 year
replace newcl=wbcode2
tsset newcl year

bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS y (dem L1.y L2.y L3.y L4.y) (y dem) () (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store e3md
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e3md_add


/*****************************Model 4: eight lags****************************************************/
sort wbcode2 year
replace newcl=wbcode2
tsset newcl year

bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS y (dem L1.y L2.y L3.y L4.y L5.y L6.y L7.y L8.y) (y dem) () (yy*), ydeep(1960) ystart(1968) yfinal(2009) truncate(4)
estimates store e4md
test l5.y l6.y l7.y l8.y
file write myfile "&&&& [" %7.3f (r(p)) "] "
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]) (lag5: _b[L5.y]) (lag6: _b[L6.y]) (lag7: _b[L7.y]) (lag8: _b[L8.y]), post
vareffects8
estimates store e4md_add


#delimit ;
estout e1 e2 e3 e4 e1gmm e2gmm e3gmm e4gmm e1md e2md e3md e4md  using "$project/results/TableGRates.tex", style(tex) 
varlabels(L.y "GDP growth first lag" L2.y "GDP growth second lag" L3.y "GDP growth third lag" L4.y "GDP growth fourth lag"  dem "Democracy") 
cells(b(star fmt(%9.3f)) se(par)) 
stats(ar2p N N_g, fmt(%7.2f %7.0f  %7.0f) labels( "\input{results/TableGRates_lags} \input{results/TableGRates_Add}  AR2 test p-value" "Observations" "Countries in sample" ))  
keep(L.y L2.y L3.y L4.y dem) 
order(dem L.y L2.y L3.y L4.y)
stardrop(dem L.y L2.y L3.y L4.y)  
nolabel replace mlabels(none) collabels(none); 
#delimit cr

#delimit ;
estout e1_add e2_add e3_add e4_add e1gmm_add e2gmm_add e3gmm_add e4gmm_add e1md_add e2md_add e3md_add e4md_add  using "$project/results/TableGRates_Add.tex", style(tex) 
varlabels(longrun "Long-run effect of democracy (on growth rate)"  level "Level effect of democracy after $limit years"  persistence "Persistence of growth rate process") 
cells(b(star fmt(%9.3f)) se(par)) 
keep(longrun level persistence) 
order(longrun level persistence)
stardrop(longrun level persistence)  
nolabel replace mlabels(none) collabels(none); 
#delimit cr

file write myfile "\\"
file close myfile




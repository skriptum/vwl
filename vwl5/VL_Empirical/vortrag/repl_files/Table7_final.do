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
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
	  , post

quietly: nlcom (effect3: _b[effect2]*_b[lag1]+_b[effect1]*_b[lag2]+_b[shortrun]) ///
	  (effect2: _b[effect2]) ///
	  (effect1: _b[effect1]) ///
	  (shortrun: _b[shortrun]) ///
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
	  (lag1: _b[lag1]) ///
	  (lag2: _b[lag2]) ///
	  (lag3: _b[lag3]) ///
	  (lag4: _b[lag4]) ///
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
sort wbcode2 year

/******************************
*******INVESTMENT**************
******************************/
gen depvar=loginvpc

xtreg depvar dem l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust
estimates store eOLS1
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eOLS1_add

xtivreg2 depvar (dem=l(1/4).demreg) l(1/4).depvar l(1/4).y yy* , fe cluster(wbcode2) robust partial(yy*)
estimates store eIV1
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIV1_add

/*Mindist*/
sort wbcode2 year
gen newcl=wbcode2
tsset newcl year
bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS depvar (dem L1.y L2.y L3.y L4.y L1.depvar L2.depvar L3.depvar L4.depvar) (depvar demreg) (y) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store eIVb1
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIVb1_add

drop depvar newcl
xtset wbcode2 year


/******************************
*******TFP**************
******************************/
gen depvar=ltfp

xtreg depvar dem l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust
estimates store eOLS2
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eOLS2_add

xtivreg2 depvar (dem=l(1/4).demreg) l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust partial(yy*)
estimates store eIV2
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIV2_add

/*Mindist*/
sort wbcode2 year
gen newcl=wbcode2
tsset newcl year
bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS depvar (dem L1.y L2.y L3.y L4.y L1.depvar L2.depvar L3.depvar L4.depvar) (depvar demreg) (y) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store eIVb2
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIVb2_add

drop depvar newcl
xtset wbcode2 year


/****************************************
*******Reforms: market**************
****************************************/
gen depvar=marketref

xtreg depvar dem l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust
estimates store eOLS3
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eOLS3_add

xtivreg2 depvar (dem=l(1/4).demreg) l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust partial(yy*)
estimates store eIV3
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIV3_add

/*Mindist*/
sort wbcode2 year
gen newcl=wbcode2
tsset newcl year
bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS depvar (dem L1.y L2.y L3.y L4.y L1.depvar L2.depvar L3.depvar L4.depvar) (depvar demreg) (y) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store eIVb3
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIVb3_add

drop depvar newcl
xtset wbcode2 year

/******************************
*******TRADE SHARE**************
******************************/
gen depvar=ltrade

xtreg depvar dem l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust
estimates store eOLS4
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eOLS4_add

xtivreg2 depvar (dem=l(1/4).demreg) l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust partial(yy*)
estimates store eIV4
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIV4_add

/*Mindist*/
sort wbcode2 year
gen newcl=wbcode2
tsset newcl year
bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS depvar (dem L1.y L2.y L3.y L4.y L1.depvar L2.depvar L3.depvar L4.depvar) (depvar demreg) (y) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store eIVb4
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIVb4_add

drop depvar newcl
xtset wbcode2 year


/******************************
*******GOVERNMENT EXPENDITURE**************
******************************/
gen depvar=lgov

xtreg depvar dem l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust
estimates store eOLS5
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eOLS5_add

xtivreg2 depvar (dem=l(1/4).demreg) l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust partial(yy*)
estimates store eIV5
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIV5_add

/*Mindist*/
sort wbcode2 year
gen newcl=wbcode2
tsset newcl year
bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS depvar (dem L1.y L2.y L3.y L4.y L1.depvar L2.depvar L3.depvar L4.depvar) (depvar demreg) (y) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store eIVb5
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIVb5_add

drop depvar newcl
xtset wbcode2 year


/******************************
*******PRIMARY ENROLLMENT**************
******************************/
gen depvar=lprienr

xtreg depvar dem l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust
estimates store eOLS6
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eOLS6_add


xtivreg2 depvar (dem=l(1/4).demreg) l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust partial(yy*)
estimates store eIV6
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIV6_add

/*Mindist*/
sort wbcode2 year
gen newcl=wbcode2
tsset newcl year
bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS depvar (dem L1.y L2.y L3.y L4.y L1.depvar L2.depvar L3.depvar L4.depvar) (depvar demreg) (y) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store eIVb6
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIVb6_add

drop depvar newcl
xtset wbcode2 year


/******************************
*******SECONDARY ENROLLMENT**************
******************************/
gen depvar=lsecenr

xtreg depvar dem l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust
estimates store eOLS7
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eOLS7_add

xtivreg2 depvar (dem=l(1/4).demreg) l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust partial(yy*)
estimates store eIV7
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIV7_add

/*Mindist*/
sort wbcode2 year
gen newcl=wbcode2
tsset newcl year
bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS depvar (dem L1.y L2.y L3.y L4.y L1.depvar L2.depvar L3.depvar L4.depvar) (depvar demreg) (y) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store eIVb7
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIVb7_add

drop depvar newcl
xtset wbcode2 year


/******************************
*******CHILD MORTALITY**************
******************************/
gen depvar=lmort

xtreg depvar dem l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust
estimates store eOLS8
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eOLS8_add

xtivreg2 depvar (dem=l(1/4).demreg) l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust partial(yy*)
estimates store eIV8
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIV8_add

/*Mindist*/
sort wbcode2 year
gen newcl=wbcode2
tsset newcl year
bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS depvar (dem L1.y L2.y L3.y L4.y L1.depvar L2.depvar L3.depvar L4.depvar) (depvar demreg) (y) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store eIVb8
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIVb8_add

drop depvar newcl
xtset wbcode2 year


/******************************
*******RIOTS AND REVOLUTIONS**************
******************************/
gen depvar=unrestn

xtreg depvar dem l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust
estimates store eOLS9
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eOLS9_add


xtivreg2 depvar (dem=l(1/4).demreg) l(1/4).depvar  l(1/4).y yy* , fe cluster(wbcode2) robust partial(yy*)
estimates store eIV9
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIV9_add

/*Mindist*/
sort wbcode2 year
gen newcl=wbcode2
tsset newcl year
bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS depvar (dem L1.y L2.y L3.y L4.y L1.depvar L2.depvar L3.depvar L4.depvar) (depvar demreg) (y) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store eIVb9
nlcom (shortrun: _b[dem])  (lag1: _b[L.depvar])  (lag2: _b[L2.depvar])  (lag3: _b[L3.depvar])  (lag4: _b[L4.depvar]), post
vareffects
estimates store eIVb9_add

drop depvar newcl
xtset wbcode2 year

#delimit ;
estout eOLS1 eOLS2 eOLS3 eOLS4 eOLS5 eOLS6 eOLS7 eOLS8 eOLS9   using "$project/results/TableChannelsTop.tex", style(tex) 
varlabels(dem "Democracy" ) 
cells(b(star fmt(%9.3f)) se(par)) 
stats( N N_g, fmt(%7.0f %7.0f) labels( "\input{results/TableChannelsTop_Add} Observations " "Countries in sample"))  
keep(dem ) order(dem )  stardrop(dem)
collabels(none)   nolabel replace mlabels(none);
#delimit cr

#delimit ;
estout eOLS1_add eOLS2_add eOLS3_add eOLS4_add eOLS5_add eOLS6_add eOLS7_add eOLS8_add eOLS9_add  using "$project/results/TableChannelsTop_Add.tex", style(tex) 
varlabels(longrun "Long-run effect of democracy"  effect$limit "Effect of democracy after $limit years"  persistence "Persistence of outcome process") 
cells(b(star fmt(%9.3f)) se(par)) 
keep(longrun effect$limit persistence) 
order(longrun effect$limit persistence)
stardrop(longrun effect$limit persistence)  
nolabel replace mlabels(none) collabels(none); 
#delimit cr

#delimit ;
estout eIV1 eIV2 eIV3 eIV4 eIV5 eIV6 eIV7 eIV8 eIV9   using "$project/results/TableChannelsMid.tex", style(tex) 
varlabels(dem "Democracy" ) 
cells(b(star fmt(%9.3f)) se(par)) 
stats( widstat jp  N N_g  , fmt(%7.1f %7.2f %7.0f %7.0f ) labels( "\input{results/TableChannelsMid_Add} Exc. instruments F-stat." "Hansen p-value"  Observations "Countries in sample" ))    
keep(dem ) order(dem )  stardrop(dem) 
nolabel replace mlabels(none) collabels(none) ;
#delimit cr

#delimit ;
estout eIV1_add eIV2_add eIV3_add eIV4_add eIV5_add eIV6_add eIV7_add eIV8_add eIV9_add  using "$project/results/TableChannelsMid_Add.tex", style(tex) 
varlabels(longrun "Long-run effect of democracy"  effect$limit "Effect of democracy after $limit years"  persistence "Persistence of outcome process") 
cells(b(star fmt(%9.3f)) se(par)) 
keep(longrun effect$limit persistence) 
order(longrun effect$limit persistence)
stardrop(longrun effect$limit persistence)  
nolabel replace mlabels(none) collabels(none); 
#delimit cr

#delimit ;
estout eIVb1 eIVb2 eIVb3 eIVb4 eIVb5 eIVb6 eIVb7 eIVb8 eIVb9   using "$project/results/TableChannelsBot.tex", style(tex) 
varlabels(dem "Democracy" ) 
cells(b(star fmt(%9.3f)) se(par)) 
stats( N , fmt(%7.0f ) labels( "\input{results/TableChannelsBot_Add} Observations" ))    
keep(dem ) order(dem )  stardrop(dem) 
nolabel replace mlabels(none) collabels(none) ;
#delimit cr

#delimit ;
estout eIVb1_add eIVb2_add eIVb3_add eIVb4_add eIVb5_add eIVb6_add eIVb7_add eIVb8_add eIVb9_add  using "$project/results/TableChannelsBot_Add.tex", style(tex) 
varlabels(longrun "Long-run effect of democracy"  effect$limit "Effect of democracy after $limit years"  persistence "Persistence of outcome process") 
cells(b(star fmt(%9.3f)) se(par)) 
keep(longrun effect$limit persistence) 
order(longrun effect$limit persistence)
stardrop(longrun effect$limit persistence)  
nolabel replace mlabels(none) collabels(none); 
#delimit cr

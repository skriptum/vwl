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
gen instrument=demreg

*Creation of spatial lags*
forvalues j=1960(1)2010{
preserve
keep if year==`j'
keep if cen_lon!=.&cen_lat!=.&y!=.&dem!=.
keep wbcode2 cen_lon cen_lat y dem year 
sort wbcode2

spmat idistance dmat cen_lon cen_lat, id(wbcode2) dfunction(dhaversine) norm(row) replace
spmat lag  y_w dmat y
spmat lag  dem_w dmat dem

keep y_w dem_w wbcode2 year
tempfile m
save `m', replace
restore

merge 1:1 wbcode2 year using `m', update
drop _m

}

sort wbcode2 year

/*******************************
Top panel: 2SLS estimates
*******************************/
quietly: xtivreg2 y l(1/4).y (dem=l.instrument) yy*, fe cluster(wbcode2) r  partial(yy*)
gen samp1=e(sample)
estimates store e1
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e1_add

quietly: xtivreg2 y l(1/4).y (dem=l(1/4).instrument) yy*, fe cluster(wbcode2) r partial(yy*)
gen samp2=e(sample)
estimates store e2
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e2_add

quietly: xtivreg2 y l(1/4).y (dem=l(1/4).instrument) yy*  interfull* if gdp1960!=. , fe cluster(wbcode2) r partial(yy*   interfull*)
gen samp3=e(sample)
estimates store e3
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e3_add

quietly: xtivreg2 y l(1/4).y (dem=l(1/4).instrument) yy*  sov1 sov2 sov3 sov4, fe cluster(wbcode2) r partial(yy*)
gen samp4=e(sample)
estimates store e4
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e4_add

quietly: xtivreg2 y l(1/4).y (dem=l(1/4).instrument) yy*  rtrend2-rtrend7, fe cluster(wbcode2) r partial(yy*)
gen samp5=e(sample)
estimates store e5
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e5_add

quietly: xtivreg2 y l(1/4).y (dem yreg tradewbreg=l(1/4).(instrument yreg tradewbreg)) yy*, fe cluster(wbcode2) r partial(yy*)
gen samp6=e(sample)
estimates store e6
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e6_add

quietly: xtivreg2 y l(1/4).y (dem yreg tradewbreg unrestreg=l(1/4).(instrument yreg tradewbreg unrestreg)) yy*, fe cluster(wbcode2) r partial(yy*)
gen samp7=e(sample)
estimates store e7
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e7_add

quietly: xtivreg2 y l(1/4).y (dem y_w=l(1/4).(instrument y_w))  yy*, fe cluster(wbcode2) r partial(yy*)
gen samp8=e(sample)
estimates store e8
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e8_add

quietly: xtivreg2 y l(1/4).y (dem l(0/4).y_w dem_w=l(1/4).(instrument dem_w) l(1/5).y_w)  yy*, fe cluster(wbcode2) r partial(yy*)
gen samp9=e(sample)
estimates store e9
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e9_add

#delimit ;
estout e1 e2 e3 e4 e5 e6 e7 e8 e9  using "$project/results/Table2SLSTop.tex", style(tex) 
varlabels(dem "Democracy" ) 
cells(b(star fmt(%9.3f)) se(par)) 
stats( jp N N_g widstat , fmt(%7.2f %7.0f %7.0f %7.1f) labels( "\input{results/Table2SLSTop_Add} Hansen p-value" "Observations" "Countries in sample"  "Exc. Instruments F-stat." ))   
keep(dem) order(dem) stardrop(dem) 
nolabel replace mlabels(none) collabels(none) ; 
#delimit cr

#delimit ;
estout e1_add e2_add e3_add e4_add e5_add e6_add e7_add e8_add e9_add using "$project/results/Table2SLSTop_Add.tex", style(tex) 
varlabels(longrun "Long-run effect of democracy"  effect$limit "Effect of democracy after $limit years"  persistence "Persistence of GDP process") 
cells(b(star fmt(%9.3f)) se(par)) 
keep(longrun effect$limit persistence) 
order(longrun effect$limit persistence)
stardrop(longrun effect$limit persistence)  
nolabel replace mlabels(none) collabels(none); 
#delimit cr

/*******************************
Mid panel: First stage
*******************************/

quietly: xtreg dem l(1/4).y l.instrument yy* if samp1==1, fe cluster(wbcode2) r  
estimates store e1fs

quietly: xtreg dem l(1/4).y l(1/4).instrument yy* if samp2==1, fe cluster(wbcode2) r 
estimates store e2fs

quietly: xtreg dem l(1/4).y l(1/4).instrument yy*  interfull* if gdp1960!=. &samp3==1, fe cluster(wbcode2) r 
estimates store e3fs

quietly: xtreg dem l(1/4).y l(1/4).instrument yy*  sov1 sov2 sov3 sov4 if samp4==1, fe cluster(wbcode2) r 
estimates store e4fs

quietly: xtreg dem l(1/4).y l(1/4).instrument yy*  rtrend* if samp5==1, fe cluster(wbcode2) r 
estimates store e5fs

quietly: xtreg dem l(1/4).y l(1/4).instrument l(1/4).(yreg tradewbreg) yy* if samp6==1, fe cluster(wbcode2) r 
estimates store e6fs

quietly: xtreg dem l(1/4).y l(1/4).instrument l(1/4).(yreg tradewbreg unrestreg) yy* if samp7==1, fe cluster(wbcode2) r
estimates store e7fs

quietly: xtreg dem l(1/4).y l(1/4).instrument l(1/4).y_w yy*  if samp8==1, fe cluster(wbcode2) r 
estimates store e8fs

quietly: xtreg dem l(1/4).y l(1/4).instrument l(1/5).y_w l(1/4).dem_w yy*  if samp9==1, fe cluster(wbcode2) r 
estimates store e9fs

#delimit ;
estout e1fs e2fs e3fs e4fs e5fs e6fs e7fs e8fs e9fs using "$project/results/TableFS.tex", style(tex) 
varlabels(L.instrument "Democracy wave t-1"  L2.instrument "Democracy wave t-2" L3.instrument "Democracy wave t-3" L4.instrument "Democracy wave t-4") 
cells(b(star fmt(%9.3f)) se(par))   
stardrop(L.instrument L2.instrument L3.instrument L4.instrument) keep(L.instrument L2.instrument L3.instrument L4.instrument ) order(L.instrument L2.instrument L3.instrument L4.instrument)   
nolabel replace mlabels(none) collabels(none) ; 
#delimit cr


/************************************************
Bottom panel: Min distance models
************************************************/
tab quintile50s, gen(dquint50s)
tab region, gen(dregion)


***************Model 1*******************
sort wbcode2 year
gen newcl=wbcode2
xtset newcl year

bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS y (dem L1.y L2.y L3.y L4.y) (y) (demreg) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(1) 
estimates store e1
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e1_add

***************Model 2*******************
sort wbcode2 year
replace newcl=wbcode2
xtset newcl year

bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS y (dem L1.y L2.y L3.y L4.y) (y) (demreg) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store e2
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e2_add

***************Model 3*******************
sort wbcode2 year
replace newcl=wbcode2
xtset newcl year

bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS y (dem L1.y L2.y L3.y L4.y) (y) (demreg) (yy* interfull*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store e3
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e3_add

***************Model 4*******************
sort wbcode2 year
replace newcl=wbcode2
xtset newcl year

bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS y (dem L1.y L2.y L3.y L4.y) (y) (demreg) (yy* sov1 sov2 sov3 sov4), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store e4
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e4_add


***************Model 5*******************
sort wbcode2 year
replace newcl=wbcode2
xtset newcl year

bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS y (dem L1.y L2.y L3.y L4.y) (y) (demreg) (rtrend2 rtrend3 rtrend4 rtrend5 rtrend6 rtrend7 yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store e5
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e5_add


***************Model 6*******************
sort wbcode2 year
replace newcl=wbcode2
xtset newcl year

bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS y (dem L1.y L2.y L3.y L4.y yreg tradewbreg) (y) (demreg yreg tradewbreg) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store e6
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e6_add



***************Model 7*******************
sort wbcode2 year
replace newcl=wbcode2
xtset newcl year

bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS y (dem L1.y L2.y L3.y L4.y yreg tradewbreg unrestreg) (y) (demreg yreg tradewbreg unrestreg) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store e7
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e7_add


***************Model 8*******************
sort wbcode2 year
replace newcl=wbcode2
xtset newcl year

bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS y (dem L1.y L2.y L3.y L4.y y_w) (y) (demreg y_w) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store e8
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e8_add

***************Model 9*******************
sort wbcode2 year
replace newcl=wbcode2
xtset newcl year

bootstrap _b, seed(12345) reps(`repsBS') cluster(wbcode2) idcluster(newcl):  hhkBS y (dem L1.y L2.y L3.y L4.y y_w L1.y_w L2.y_w  L3.y_w  L4.y_w dem_w) (y) (demreg y_w dem_w) (yy*), ydeep(1960) ystart(1964) yfinal(2009) truncate(4)
estimates store e9
nlcom (shortrun: _b[dem])  (lag1: _b[L.y])  (lag2: _b[L2.y])  (lag3: _b[L3.y])  (lag4: _b[L4.y]), post
vareffects
estimates store e9_add


#delimit ;
estout e1 e2 e3 e4 e5 e6 e7 e8 e9 using "$project/results/Table2SLSbot.tex", style(tex) 
varlabels(dem " Democracy" ) 
cells(b(star fmt(%9.3f)) se(par)) stats( N , fmt(%7.0f) labels( "\input{results/Table2SLSBot_Add}  Observations"))   
keep(dem) order(dem) stardrop(dem) 
nolabel replace mlabels(none)  collabels(none);  
#delimit  cr

#delimit ;
estout e1_add e2_add e3_add e4_add e5_add e6_add e7_add e8_add e9_add using "$project/results/Table2SLSBot_Add.tex", style(tex) 
varlabels(longrun "Long-run effect of democracy"  effect$limit "Effect of democracy after $limit years"  persistence "Persistence of GDP process") 
cells(b(star fmt(%9.3f)) se(par)) 
keep(longrun effect$limit persistence) 
order(longrun effect$limit persistence)
stardrop(longrun effect$limit persistence)  
nolabel replace mlabels(none) collabels(none); 
#delimit cr







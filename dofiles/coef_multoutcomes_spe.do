********************************************************************************

**# 	[COEFPLOT: MULTIPLE OUTCOMES WITH DIFF SPECIFICATIONS/SUBSAMPLES]

********************************************************************************
* RUN REGRESSIONS TO GET COEFFICIENTS:	
	* Grades 1-3
	use "${processed_data}/grades_123.dta", clear
	keep if inrange(grade, 2, 3)	// Grade 1 kids don't have many baseline collections
	foreach var of global outcomes_young {
		* Controls + strata_FE
		reghdfe and_`var'_3 treat $controls_rct2 if swedish !=. & region_id !=., absorb(region_id swedish) vce(cluster schoolnr)
			eststo `var'_123
	}
	
	* Grades 4-6:
	use "${processed_data}/grades_456.dta", clear
	foreach var of global outcomes_old {
		* Controls + strata_FE
		reghdfe and_`var'_3 treat $controls_rct1, absorb(region_id swedish ) vce(cluster schoolnr)
			eststo `var'_456
	}
	
	
	* Grades 7-9
	use "${processed_data}/grades_789.dta", clear
	keep if inrange(grade, 8, 9)	// Grade 1 kids don't have many baseline collections
	foreach var of global outcomes_old {
		* Controls + strata_FE
		reghdfe and_`var'_3 treat $controls_rct1, absorb(region_id swedish ) vce(cluster schoolnr)
		eststo `var'_789
	}


* COLLECT LOCALS FOR GRAPH OPTIONS FOR EACH SPECIFICATION/SUBSAMPLE:
*   - offset: to make the coeffients of the diff specifications not be drawn one in top of the other
*   - mlcolor and mfcolor: set the color of the market and its line
*   - ciopts: specify options for the confidence intervals 
	local coef_123 offset(-0.12) mlcolor(black) mfcolor(black) ciopts(lwidth(1) color(black) lcolor(*.6))
	local coef_456 mlcolor(teal) mfcolor(teal) ciopts(lwidth (0.8 ) color(teal) lcolor(*.6))
	local coef_789 offset(0.12) mlcolor(maroon) mfcolor(maroon) ciopts(lwidth (0.8 ) color(maroon) lcolor(*.6))

* CREATE COEFPLOT:
*   - || Indicates the separation between subgraphs. In this case we have three "series" (subsamples) for each subgraph.
*       Coefplot uses the same options across subgraphs for each position. Since for mental health we don't have the
*       first subsample, you use `_skip' to tell it not apply the first options to the next series.
*   - "bycoefs" allows you to use different stored estimates as the individual coefficents in graphs 
*         (default is to use only one stored estimate and plot different variables). 
*   - xlab: when using "bycoefs" we specify the order through the number of the subgraph !!!!!!
*   - "plotlabels": adds the legend explaining the differences between specifications/subsamples

	#delimit ;
	
	coefplot (bul_123, `coef_123') (bul_456, `coef_456') (bul_789, `coef_789') ||
		vic_123 vic_456 vic_789 || _skip mh_456 mh_789 ,
		keep(treat)
		bycoefs
		order(bul_123 bul_456 bul_789 vic_123 vic_456 vic_789 mh_123 mh_456 mh_789)
		vertical
		xlab(1 "Bullying" 2 "Victimization" 3 "Mental Health")
		grid(none) yline(0, lcolor(gs12)) 
		plotlabels("Grades 1-3" "Grades 4-6" "Grades 7-9") 
		msymbol(d)
		;

	#delimit cr	
	
	graph export "${figures}/RCT/rct_main_bygrade.pdf", as(pdf) replace
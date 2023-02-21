********************************************************************************

**#         [COEFPLOT: HETEROGENEITY ANALYSIS]

********************************************************************************

** RUN REGRESSION: BASELINE + EACH HETEROGENEITY DIMENSION
foreach v in wl_1y wl_10y {
	* Whole sample:
	qui areg `v' treat $controls wl_base, absorb(kanton_code) vce(robust)
		qui eststo baseline_`v'

	foreach h in $hetero2 {
		* Heterogeneity dimension = 0
		qui areg `v' treat $controls wl_base if `h'==0, absorb(kanton_code) vce(robust)
			qui eststo `h'_0_`v'

		* Heterogeneity dimension = 1
		qui areg `v' treat $controls wl_base if `h'==1, absorb(kanton_code) vce(robust)
			qui eststo `h'_1_`v'
	} // het loop
}

* COLLECT LOCALS FOR GRAPH OPTIONS FOR EACH SPECIFICATION/SUBSAMPLE:
*   - mlcolor and mfcolor: set the color of the market and its line
*   - ciopts: specify options for the confidence intervals 
      local coef_black  mlcolor(black) mfcolor(black) ciopts(lwidth(1) color(black) lcolor(*.6))
      local coef_teal mlcolor(teal) mfcolor(teal) ciopts(lwidth (0.8 ) color(teal) lcolor(*.6))
		

* CREATE COEFPLOT:
*   - || Indicates the separation between subgraphs (here each subgraph is a different outcome). For each subgraph,
*           we include all the estimates for each of our heterogeneity dimensions. "bylabel" specified the title for each subgraph
*     - "asequation" "swapnames": means that each series will be from a different model. In our case, we then use "headings" to break
*           to create certain groups across series
*	- "eqrename": specifies how the coefficients are called internally by the program. In this case, we want the estimate for each heterogeneity
*           dimension to be in the same row for both outcomes, so we first (eqrename works first than swapnames!) have to put the stored estimates
*           from both outcomes to the same naming structure using regex (i.e. it gets rid of the "wl_1y" or "wl_10y" of each estimate name)
*     - "coeflabels": specifies ecactly which name we want for each coefficient
*     - nokey: necessary if we don't want a plot legend when we combine several subgraphs like this into one
*     - addplot: necessary to add design elements when we have combined subgraphs (IMP: norescaling option is necessary)

      #delimit ;
      
      coefplot (baseline_wl_1y, `coef_black') (*_0_wl_1y *_1_wl_1y, `coef_teal'), bylabel("1y WL")
                  ||
                  (baseline_wl_10y) (*_0_wl_10y *_1_wl_10y) , bylabel("10y WL") 
                  ||,
            keep(treat) asequation swapnames 
            eqrename( baseline_.* = baseline ([a-zA-Z]+)_0_.* = \1_0 ([a-zA-Z]+)_1_.* = \1_1 , regex)
            order(baseline med_base* c_cost* pension* med_gen* med_wl* org_fam* org_work* c_qual* med_age* med_cage*)
            coeflabels( 
                              baseline = "{bf:Baseline Estimate}" 
                              med_base_0 = "Below median"
                              med_base_1 = "Above median"
                              c_cost_0 = "Not important"
                              c_cost_1 = "Important"
                              pension_over_0 = "Good or underestimate"
                              pension_over_1 = "Overestimated"
                              med_gen_0 = "Below median"
                              med_gen_1 = "Above median"
                              med_wl_0 = "Below median"
                              med_wl_1 = "Above median"
                              org_fam_0 = "Not hard"
                              org_fam_1 = "Hard"
                              org_work_0 = "Not hard"
                              org_work_1 = "Hard"
                              c_qual_0 = "Same or better" 
                              c_qual_1 = "Worse" 
                              med_age_0 = "Below median"
                              med_age_1 = "Above median"
                              med_cage_0 = "Below median"
                              med_cage_1 = "Above median"
                              , labsize(vsmall) notick
                              )						
            headings( 	med_base_0 = "{bf: By index of baseline financial awareness}" 
                              c_cost_0 = "{bf: By importance of childcare}" 
                              pension_over_0 = "{bf: By pension estimation}"  
                              med_gen_0 = "{bf: By conservative gender views}"	
                              med_wl_0 = "{bf: By baseline WL}" 
                              org_fam_0 = "{bf:By difficulty of organizing family life}"
                              org_work_0 = "{bf: By difficulty of adjusting WL}" 
                              c_qual_0 = "{bf: By belief about ext. childcare quality}"
                              med_age_0 = "{bf: By mother's age}"
                              med_cage_0 = "{bf: By youngest child's age}"
                              )  
            groups(c_cost_? pension_over_? = `""{it:By baseline}" "{it:financial awareness}""', angle(90))
            grid(none) msymbol(d) 
            legend(off)
            nokey
            ;

            #delimit cr	
            addplot : , xline(0, lp(dash)) norescaling
            graph export "${path_figures}\\`data'\\outcomes2_heterogeneity.pdf", as(pdf) replace
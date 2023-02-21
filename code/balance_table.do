/******************************************************************************
	Purpose:				Template for manual balance table 	
******************************************************************************/

    clear all
    set more off, permanently

** PACKAGES:
// Download attregtest, and add to ado directory: https://github.com/daghanem/ATTRITIONTESTS
// This implements the attrition tests proposed in Ghanem, Hirshleifer, and Ortiz-Becerra (2020)
* ssc install leebounds

** LOAD DATA: 
use "${processed_data}/datafile.dta", clear

* Define control variables:
global controls 

************************************************************************
**#		                 1. DETECTING ATTRITION     
************************************************************************
** CHECK PARTICIPATION PATTERNS
* Sometimes you might get people who drop btwn waves AND also people
* who only answer a later wave and not the baseline (bad RCTs)
    tab wave1 wave2


** DEFINE ATTRITION:
    gen attrit =. (wave1 == 1 & wave2 == 0)    //strict measure
        replace attrit = 1 if (wave1 == 1 & wave2 == 0)
        replace attrit = 0 if (wave1== 1 & wave2 == 0)
    label var attrit        "Attritor"

* NOTE: Dhar et al 2022 propose a broad measure of attrition, where they code
* non-attritors as anyone who participates in wave2 regardless of whether
* they participated in baseline.

**# 1.1 OVERALL ATTRITION RATE ******************************************
    tab attrit

**# 1.2 DIFFERENTIAL ATTRITION RATE *************************************
    #delim ;
    iebaltab attrit, replace                                   
            grpvar(treat) vce(cluster fancy_clustering)         
            grplabels("1 Treatment @ 0 Control") rowvarlabel    
            savetex("${output_tbl}/balancetable_attrition")    
    # delim cr

************************************************************************
**#		                 2. ATTRITION ADJUSTMENT    
************************************************************************

** TABLE 1: BASELINE CHARACTERISTICS
	texdoc init "${path_tables}\textual_analysis\stats_bygender.tex", replace force
		
		* Table Heading
	* TABLE HEADING
		tex \begin{tabular}{l*{4}{c}} 
		tex \toprule
		tex & Control & Treated & Mean difference \\
		tex & (1) & (2) & (3)  \\
		tex \midrule
		
		* TABLE CONTENTS (loop through variables)
		foreach var in $baseline_chars {
			
			* SPECIFY HEADERS IF NECESSARY
			if "`var'" == "age_30" {
				tex \multicolumn{1}{l}{\textbf{Demographics}} \\
			}
			if "`var'" == "wl_base" {
				tex \multicolumn{1}{l}{\textbf{Work and constraints}} \\
			}
			if "`var'" == "child_suffer" {
				tex \multicolumn{1}{l}{\textbf{Beliefs}} \\
			}
			
			* STORE VALUES FOR EACH VARIABLE
			// Get variable label:
			local varname: var lab `var'
			
			// Mean and sd for treatment arms:
			qui reg `var' treat_all, cluster(schule_code)
			local control_mean:  di %6.2f r(table)[1,2]
			local treat_mean:  di %6.2f r(table)[1,2] + r(table)[1,1]
			local difference: di %6.2f r(table)[1,1] 
			local p_value: di %6.2f r(table)[4,1]     		// Uncomment if only want simple p-values

	
			// (OPTIONAL): Format differences to get significance stars 
			if `p_value' > .05 & `p_value' <= .1 {
				local difference = "`difference'\rlap{*}"
			}
			else if `p_value' > .01 & `p_value' <= .05 {
				local difference = "`difference'\rlap{**}"
			}
			else if `p_value' <= .01 {
				local difference = "`difference'\rlap{***}"
			}
			else {
				local difference = "`difference'"	
			}
			
			local difference = subinstr("`difference'","-","\llap{-}", .)
			
			* WRITE OUT ROWS
			tex \hspace{5mm} `varname' & $ `control_mean' $ & $ `treat_mean' $ & $ `difference' $  \\ [1ex]
			sleep 1000
			
		} // end var loop
		
		* TABLE FOOT
		tex \bottomrule
		
		// Add observations:
			ttest age_group, by(treat_all)
			local n_1: di %4.0f r(N_1)
			local n_2: di %4.0f r(N_2)
			local n: di %4.0f r(N_1) + r(N_2)
			
		tex Obs. & $`n_1'$ & $`n_2'$ & $`n'$ \\
		tex \bottomrule
		tex \multicolumn{4}{l}{\footnotesize Significance levels: * p $<$ 0.10, ** p $<$ 0.05, *** p $<$ 0.01} \\
		tex \multicolumn{4}{l}{\footnotesize Standard errors are clustered at school-level.} \\
		tex \end{tabular}

		* Close table 
		texdoc close
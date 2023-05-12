/*******************************************************************************
	Purpose:			Template for summary statistic table (automatic + manual)
    Comments            1. Out of all the alternatives, I prefer esttab for ease
                            of use.
*******************************************************************************/

    clear all
    set more off, permanently

** PACKAGES:
* ssc install esttab  // For automatic creation

** LOAD DATA: 
    use "${processed_data}/datafile.dta", clear

****************************************************************************
**#		                [1. AUTOMATIC: USING ESTTAB]     
****************************************************************************

* GET SUMMARY STATISTICS:
    local sum_vars registered voted voted_reg hispanic $controls_indv 
                            
    estpost summarize `sum_vars' 
    eststo summstats
        
	
	
* CREATE TABLE USING ESTTAB:
*   - indicates
*   - indicates
*   - booktab: better rendering in Latex (requires booktab pack. in latex too)

    #delimit ;

    esttab summstats using "${tables}/T1_summarystats_playground.tex", replace
		title("Summary statistics (PLAYGROUND)") 
		nonumbers
		collabels("Mean" "SD" "Min" "Max")
		cell("mean(fmt(%6.2f)) sd(fmt(%6.2f)) min(fmt(%6.2g)) max(fmt(%6.1g))") 
		refcat(registered "\textbf{Main effects}" mixedstatus "\textbf{Controls}", nolabel) 
		label 
		addnotes ("Note: Sample contains U.S. citizens aged 18 or older" 
	"Source: 2004-2014 Current Population (CPS) November Voting and Registration Supplements") 
		compress 
		booktab 
		;

    #delimit cr

****************************************************************************
**#		                [2. FULLY CUSTOMIZABLE TABLE]     
****************************************************************************

*  COLLECT VARIABLES: this code requires it to be a global
	global summstats

	
* CREATE LATEX TABLE:
    * Open table contents
	texdoc init "${path_tables}\summarystats.tex", replace force
		
		* TABLE HEADING
		tex \begin{tabular}{l*{6}{c}} 
		tex \toprule
		tex & Mean & Min & Max & Obs. & Missing  \\
		tex \midrule
		
		* TABLE CONTENTS (loop through variables)
		foreach var of varlist $fu_vars {
			
			* SPECIFY HEADERS IF NECESSARY
			if "`var'" == "satisfied_friends" {
				tex \multicolumn{1}{l}{\textbf{Satisfied with ...}} \\
			}
			if "`var'" == "demand_work" {
				tex \multicolumn{1}{l}{\textbf{Social desirability traits}} \\
			}
			
			* STORE VALUES FOR EACH VARIABLE
			// Get variable label:
			local varname: var lab `var'
			
			// Mean and sd for treatment arms:
			qui summarize `var'
			local mean:  di %6.2f r(mean)
			local min:  di %6.2g r(min)
			local max: di %6.2g r(max) 
			local obs: di %6.2g r(N)
			
			qui count if `var' == . 
			local missing: di %6.2g r(N)
	
					
			* WRITE OUT ROWS
			tex \hspace{5mm} `varname' & $ `mean' $ & $ `min' $ &  $`max'$  & $ `obs' $ & $ `missing' $  \\ [1ex]
			sleep 1500
			
		} // end var loop
		
		* TABLE FOOT
		tex \bottomrule
		tex \end{tabular}

	* Close Latex document 
	texdoc close
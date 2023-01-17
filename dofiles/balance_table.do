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
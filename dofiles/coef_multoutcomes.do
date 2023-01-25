********************************************************************************

**# 	[COEFPLOT: MULTIPLE OUTCOMES (ONE SPECIFICATION/SUBSAMPLE)]

********************************************************************************
* RUN REGRESSION AND STORE RESULTS:
foreach v in $wl_main_fu $wl_inc_fu $dif{
		* With controls:
		qui reg `v' treat $controls wl_base i.kanton_code, robust
			eststo `v'_c
	}

* CREATE COEFPLOT:
*   - Note: all series plotted on the same subgraph, and since we want them to look the same, we specify all
*		aesthetic options at the level of subgraph (aka after all the series-,)
*   - "asequation" "swapnames": means that each plot will be from a different model
*	- "eqrename": specified the name by which we want to see below each coeffient (tells you the outcome in this case)


	#delimit ;
	coefplot (wl_1y_fu_c wl_10y_fu_c  inc_wl_3y_c inc_wl_5y_c inc_wl_10y_c avg_wl_fu_c dif_1y_fu_c), 
			keep(treat) asequation swapnames 
			eqrename(
					wl_1y_fu_c = "1y WL"
					wl_10y_fu_c= "10y WL"
					inc_wl_3y_c = "3y WL (canton)" 
					inc_wl_5y_c = "5y WL (canton)" 
					inc_wl_10y_c = "10y WL (canton)" 
					avg_wl_fu_c = "Avg. WL" 
					dif_1y_fu_c = "Dif Wl 1y"
					) 
			vertical yline(0, lcolor(gs14)) 		
			ylabel(#4, format(%6.2g) )
			mlabel mlabcolor(black) format(%6.3f) mlabposition(2)
			msymbol(d)  mlcolor(black) mfcolor(black) ciopts(lwidth(1) color(black) lcolor(*.6))
			legend(off) ;
			
	#delimit cr
	
	graph export "${path_figures}\outcomes2.pdf", as(pdf) replace
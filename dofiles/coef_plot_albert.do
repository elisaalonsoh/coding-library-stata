coefplot gym_compl gym_compl_age gym_compl_ses gym_compl_educpar gym_compl_inc gym_compl_workf ///
        gym_compl_gender gym_compl_adhd, ///
         keep(any_paths treat_fem treat_male ///
            treat_hinc treat_lowinc treat_gymbothpar treat_gympar treat_nogym ///
            treat_workfath treat_noworkfath treat_lses treat_hses ///
             treat_hiadhd treat_lowadhd ///
             treat_hiage treat_lowage) ///
         xline(0) xscale(range(-.2(.1).2)) xlabel(-.2(.1).2) ///
         xline(0.0707, lp(dash) lcolor(blue)) msymbol(D) mcolor(edkblue) ///
         grid(none) yscale(range(0 31)) scale(0.7) aspectratio(3.2) ///
        coeflabels ( ///
                 treat_lowage = "Below Median" treat_hiage = "Above Median" ///
                 treat_gymbothpar = "Both Parents Higher Education" ///
                 treat_gympar = "One Parent Higher Education" treat_nogym = "Both Parents No Higher Education" ///
                 treat_hinc = "Above Median" treat_lowinc = "Below Median" ///
                treat_workfath = "Working" treat_noworkfath = "Not Working" /// 
                treat_lses ="Low SES" treat_hses ="High SES" ///
                any_paths = "{bf:Baseline Estimate}" treat_fem = "Female" treat_male ="Male"  ///
                t_swiss_mother="Swiss Mother" t_not_swiss_mother="Not Swiss Mother" ///
                 treat_hiadhd = "Above Median" treat_lowadhd = "Below Median" ///
                , labsize(medsmall) notick) ///
        headings( ///

                    treat_hiage = "{bf:Age}" ///

                    treat_lses ="{bf:SES}" ///

                    treat_fem = "{bf:Gender}"  ///

                    treat_gymbothpar = "{bf:Parental Education}" ///

                    treat_hinc = "{bf:Family Income}"                        ///

                    treat_workfath ="{bf:Father Employment}" ///

                    treat_hiadhd = `""{bf:ADHD Symptoms}" "{bf:(Disruptiveness & Impulsiveness)}""' ///

                    , labsize(medsmall)) ///

    levels(95 90) ciopts(lwidth(2 ..) color(edkblue edkblue) lcolor(*.3 *.6 ; )) ///

    title("(a) High School Completion") legend(subtitle(Confidence Interval:)  ///

    order( 1 "95%" 2 "90%") row(1) span) graphregion(color(white)) name("graph_completed", replace)
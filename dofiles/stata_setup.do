/******************************************************************************
*******************************************************************************
	Purpose:					
	Author:					Elisa Alonso Herrero (EA)			
	Created on:				Date (Updated on:)	
	Last modification:		Date (who and what)								
	Status:					in process 

	Comments: 				1. 
******************************************************************************
******************************************************************************/

/*	TABLE OF CONTENTS

	1. SETUP
	2. SECTION
		2.1 Sub-section
*/

/*  INPUT FILES
	- "${rawdata}/file"
*/

/*  OUTPUT FILES
	- "${processed_data}/file"				// Brief description
*/


/*=====================================================================
							[1. SETUP]
=======================================================================*/

clear all
version 17 
set more off, permanently

** DEFINE DIRECTORY STRUCTURE:
	local user = c(username)
	
	if "`user'"=="elisa"{
		global dir "C:/Users/elisa/Dropbox"
	} 
		
	if "`user'"=="elalon"{
		global dir "C:/Users/elalon/Dropbox"
	} 

* Directory globals
	global rawdata ""
	global processed_data ""
	global code ""
	global output_tbl ""
	global output_gph ""
	global output_log ""

** PACKAGES:

** FIGURE SCHEME: 
* Options: uncluttered, plotplain
set scheme uncluttered


* Log
	capture log close
	log using "${output_log}/logname", text replace


/*=====================================================================*/
**#  						[2. SECTION]
/*=======================================================================*/

**# 2.1 SUBSECTION -----------------------------------------------------


log close
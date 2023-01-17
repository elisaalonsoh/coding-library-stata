/******************************************************************************
*******************************************************************************
	Purpose:					
	Author:					Elisa Alonso Herrero (EA)			
	Created on:				Date 	
	Last modification:		Date (who and what)								
	Status:					in process 

	Comments: 				1. 
	Output:					""
******************************************************************************
******************************************************************************/

/*	TABLE OF CONTENTS

	0. SETUP
	1. SECTION
		1.1 Sub-section
*/

/*  INPUT FILES
	- "${rawdata}/file"
*/

********************************************************************************

**# 						0. SETUP

********************************************************************************

clear all
clear matrix
version 17 
set more off, permanently
capture log close

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

* Log
	capture log close
	log using "${output_log}/logname", text replace

** PACKAGES:

** FIGURE SCHEME: 
* Options: uncluttered, plotplain
set scheme uncluttered

**********
* COLLECT GLOBALS (from all dofile)
**********


********************************************************************************

**# 						1. SECTION

********************************************************************************

**# 1.1 SUBSECTION -----------------------------------------------------


log close
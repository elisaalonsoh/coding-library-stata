/******************************************************************************
*******************************************************************************
	Purpose:				Create a fake dataset from scratch				
	Author:					Elisa Alonso Herrero (EA)	
	
	Description:			5000 students followed across 4 years. Treatment is 
							assigned at the school-level. We have demographic 
							characteristics of the students, and our outcomes
							are their grades in some exams and whether they 
							enroll in university.							
							
******************************************************************************
******************************************************************************/



********************************************************************************

**# 						0. SETUP

********************************************************************************

clear all
clear matrix
version 16
set more off, permanently

********
** DEFINE DIRECTORY STRUCTURE:
*******

	global dir "C:\Users\elisa\Dropbox\Learning\Programming\Coding libraries\coding-library-stata"

* Directory globals
	global data "${dir}\data"



********************************************************************************

**# 					[1. CREATE FAKE DATA]

********************************************************************************
	* Generate fake dataset
	set seed 1234
	set obs 20

	* Create person ID variable
	gen person_id = ceil(_n/4)

	* Create year variable from 2000 to 2003
	gen year = 2000 + mod(_n-1, 4)

	* Create age variable based on person ID and year
	gen age = (person_id-1)*4 + (year-2000)

	* Create other variables with random values
	gen income = rnormal(1000, 100)
	bys person_id: gen education = ceil(runiform()*20)
	
	/*
	* Set seed so randomness is replicable in your system
	set seed 1234
	
	* Set number of observations you want in your dataset
	set obs 5000
	
	* Generate a unique identifier for each student
	gen id = _n
	
	* Generate random ages between 12 and 16 for each student:
	gen age = floor((16 - 12 + 1) * runiform() + 12)
	
	* Generate a random school ID for each student, with 30 schools in total:
	gen school = floor((30) * runiform() + 1)

	* Assign 15 schools to treatment group and 15 to the control group
	gen treat = cond(school <= 15, 1, 0)
	
	* Generate data for 4 different years
	expand 4
	bys id: gen year = _n

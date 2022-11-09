*! ddrate version 0.4 GR 4-Feb-06 (Decomposition of a difference in rates)

program define ddrate
version 9
	syntax varlist (min=4 max=4) [, Names(namelist min=2 max=2) Rates]
	if ("`names'" == "") {
		local names = "1 2"
	}
	// let mata do it
	tempname result
	mata: ddr("`varlist'","`result'", "`rates'"!="")

	// print results
	tokenize `names'
	ddr_print "`1'" "`2'" "`result'"
end

mata:
void ddr(string scalar varlist, string scalar result, real scalar rates)
{
// varlist has pop1 deaths1 pop2 deaths2 in that order, 
// returns results in 4x3 matrix
	names = tokens(varlist)

	c1 = st_data(.,names[1])
	r1 = st_data(.,names[2])
	if(!rates) r1 = r1 :/ c1
	c1 = c1 :/ sum(c1)
	c2 = st_data(.,names[3])
	r2 = st_data(.,names[4]) 
	if(!rates) r2 = r2 :/ c2
	c2 = c2 :/ sum(c2)
	
	ca = (c1+c2) :/ 2
	ra = (r1+r2) :/ 2

	R = ( c1'r1, c1'ra, ca'r1  \
	      c2'r2, c2'ra, ca'r2  )
	R = R \ R[1,.]-R[2,.] 
	R = 1000 * R \ 100 * R[3,.]/R[3,1]
	st_matrix(result,R)
}
end

program define ddr_print
* called with two row labels and matname
	di
	display "{text}Decomposition of a difference in rates"
	di
	di "Population   {c |}    Observed   Composition     Rates"
	di "{hline 13}{c +}{hline 36}"
	ddr_putline "`1'" `3' 1
	ddr_putline "`2'" `3' 2
	di "{txt}{hline 13}{c +}{hline 36}"
	ddr_putline "Difference" `3' 3 
	ddr_putline "% due to"   `3' 4 %12.1f
end

program define ddr_putline
* called with rowlab matname rownumb [format]
	local line = "{txt}`1' {col 14}{c |}{res}"
	if ("`4'"=="") local 4 %10.2f
	forvalues j=1/3 {
		local value : display `4' `2'[`3',`j'] 
		local line `line'{ralign 12:`value'}
	}
	display "`line'"
end

exit

G. Rodriguez <grodri@Princeton.edu>
Eco572 - Spring 2006

Example:

infile i str5 age swpop swdeaths kzpop kzdeaths using ///
    http://data.princeton.edu/eco572/datasets/prestont21.raw
ddrate swpop swdeaths kzpop kzdeaths, names(Sweden Kazakhstan)
	

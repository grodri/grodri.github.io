*! myers version 0.5 GR 2 Feb 2006 (Myers blended infex of digit preference)
program define myers, rclass
version 9
	syntax varname [if] [in] [fweight] ///
		[, Range(numlist asc int min=2 max=2) months Generate(name)]
	if ("`generate'" != "") {
		confirm new var `generate'
	}
	local age `varlist'
	local unit = 10
	if ("`months'" != "") {
		local unit = 12
	}

	// range of values to be used
	quietly sum `age' `if' `in'
	local bot = r(min)
	local top = r(max) - `unit'
	local max = r(max)
	if ("`range'" != "") {
		gettoken bot top : range
		if (`bot' < r(min) | `top'> r(max)) {
			di as error "Range `bot' to `top' extends outside valid values"
			error 121
		}
	} 
	if abs(mod(`top'-`bot'+1,`unit')) > 0.01 {
		di as error "Range `bot' to `top' should span a multiple of `unit'"		
		error 121
	}
// ------------------ Myers' Blended Index -------------------

	// last digit and Myers' weight
	tempname lastdigit mwgt matcell myers
	gen `lastdigit' = mod(`age',`unit')
	label var `lastdigit' "Last digit"
	gen `mwgt' = `unit'
	quietly replace `mwgt' = `age' -`bot'+1  if `age' < `bot'+ `unit'
	quietly replace `mwgt' = `top' + `unit' - `age' if `age' > `top'
	quietly replace `mwgt' = 0 if `age' < `bot' | `age' > `top' + `unit' - 1
	//debug	list `age' `mwgt' 
	
	// multiply Myers's and user's weights
	if ("`exp'" != "") {
		local fweight = substr("`exp'",2,.) // eliminate equal sign
		quietly replace `mwgt' = `mwgt' * `fweight'
	}

	// tabulate and compute index
	tabulate `lastdigit' `if' `in' [fw=`mwgt'], matcell(`matcell')
mata: f = st_matrix("`matcell'")
mata: m = 100*sum(abs( f/sum(f) :- 1/`unit'))/2 
mata: st_numscalar("`myers'", m )

	// print results
	di
	di "{text}Myers' Blended Index = {result}" `myers'
	if (`top' + `unit' - 1 > `max') {
		di "{text}(Assuming zero frequencies for values " `max'+1 " to " `top'+`unit'-1 ")"
	} 

	// saved results
	if ("`generate'" != "") {
		gen `generate' = `mwgt'
		label var `generate' "Myers's blended weight times `fweight'"
	}
	return scalar myers = `myers'
end

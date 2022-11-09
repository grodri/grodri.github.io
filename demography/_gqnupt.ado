program define _gqnupt
*! quantiles of age at marriage in Coale-McNeil model - GR Mar 2006
	syntax newvarname=/exp [if] [in], Mean(real) Stdev(real) [Pem(real 1.0)]
	if (`stdev' <= 0 ) {
		di as error "Standard deviation must be non-negative"
		exit 198
	}
	if (`pem' <= 0 | `pem' > 1) {
		di as error "Probability of ever marrying must be between 0 and 1"
		exit 198
	}
	capture assert 0 < `exp' & `exp' < `pem'
	if _rc > 0 {
		di as error "The probabilities must be between 0 and pem"
		exit 198
	}
	tempvar touse p g z	
	quietly {
		gen `touse'= 1 `if' `in'
		gen `p' = 1-`exp'/`pem'
		gen `g' = invgammap(0.604, `p') if `touse'==1
		gen `z' = -0.805 - log(`g')/1.896 if `touse'==1
		gen `typlist' `varlist' = `mean' + `stdev' * `z' if `touse'==1
	}
end

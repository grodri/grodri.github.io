program define _gpnupt
*! Proportions ever married in Coale-McNeil model - GR Mar 2006
	syntax newvarname=/exp [if] [in], Mean(real) Stdev(real) [Pem(real 1.0)]
	if (`stdev' <= 0 ) {
		di as error "Standard deviation must be non-negative"
		exit 198
	}
	if (`pem' <= 0 | `pem' > 1) {
		di as error "Probability of ever marrying must be between 0 and 1"
		exit 198
	}
	tempvar z touse
	quietly {
		gen byte `touse'=1 `if' `in'
		gen `z' = (`exp'-`mean')/`stdev' if `touse'==1
		gen `typlist' `varlist' = `pem' * ///
			(1 - gammap(0.604, exp(-1.896 * (`z' + 0.805)))) ///
			if `touse'==1
	}
end

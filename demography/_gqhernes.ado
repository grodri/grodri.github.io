program define _gqhernes
*! quantiles of age at marriage in Hernes model - GR Mar 2006
	syntax newvarname=/exp [if] [in], A(real) R(real) Pem(real)
	if (`a' <= 0 | `r' <= 0) {
		di as error "Attractiveness/decay parameters must be non-negative"
		exit 198
	}
	if (`pem' <= 0 | `pem' >= 1) {
		di as error "Probability of ever marrying must be between 0 and 1"
		exit 198
	}
	capture assert (0 < `exp' & `exp' < `pem') `if' `in'
	if _rc > 0 {
		di as error "The probabilities must be between 0 and pem"
		exit 198
	}
	tempvar touse y
	quietly {
		gen `touse'= 1 `if' `in'
		gen `y' = logit(`pem')-logit(`exp') if `touse'==1
		gen `typlist' `varlist' = ///
			15-log(`y'*`r'/`a')/`r' if `touse'==1
	}
end

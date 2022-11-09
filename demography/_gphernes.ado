program define _gphernes
*! proportions ever married in Hernes model - GR Mar 2006
	syntax newvarname=/exp [if] [in], A(real) R(real) Pem(real)
	if (`a' <= 0 | `r' <= 0) {
		di as error "Attractiveness/decay parameters must be non-negative"
		exit 198
	}
	if (`pem' <= 0 | `pem' >= 1) {
		di as error "Proportion ever married must be strictly between 0 and 1"
		exit 198
	}
	tempvar x touse
	quietly {
		gen byte `touse'=1 `if' `in'
		gen `x' = exp(-`r'*(`exp'-15))  if `touse'==1
		gen `typlist' `varlist' = invlogit(logit(`pem') -`a'*`x'/`r') if `touse'==1
	}
end

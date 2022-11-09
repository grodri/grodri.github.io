program define _gmarfer
*! Coale's model of marital fertility - GR Apr 2006
version 9
	syntax newvarname=/exp [if] [in] [, Level(real 1) Control(real 0)]
	if (`level' <= 0 ) {
		di as error "Level parameter (big M) must be positive"
		exit 198
	}
	if (`control' < 0) {
		di as error "Control parameter (little m) must be non-negative"
		exit 198
	}
	tempvar age touse
	quietly {
		gen byte `touse'=1 `if' `in'
		gen `typlist' `varlist' = `exp' if `touse'==1
		mata: mf("`varlist'","`touse'",`level',`control')
	}
end

mata:
void mf(varname, tousename, level, control)
{
	age = getsubset(varname,tousename)
	r = level*natfer(age) :* exp( -control*confer(age) )
	putsubset(varname,tousename,r)
}
end

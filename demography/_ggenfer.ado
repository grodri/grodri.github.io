program define _ggenfer
*! Coale-Trussell model of general fertility - GR Apr 2006
version 9 
syntax newvarname=/exp [if] [in] , [Level(real 1) Control(real 0)] Mean(real) Stdev(real)
	if (`level' <= 0 ) {
		di as error "Level parameter (big M times pem) must be positive"
		exit 198
	}
	if (`control' < 0) {
		di as error "Control parameter (little m) must be non-negative"
		exit 198
	}
	if (`mean' < 0) {
		di as error "Mean age at marriage must be non-negative"
		exit 198
	}
	if (`stdev' < 0) {
		di as error "Standard deviation of age at marriage must be non-negative"
		exit 198
	}
	tempvar age touse
	quietly {
		gen byte `touse'=1 `if' `in'
		gen `typlist' `varlist' = `exp' if `touse'==1
		mata: gf("`varlist'","`touse'",`level',`control',`mean',`stdev')
	}
end

mata:
void gf(varname, tousename, level, control, mean, stdev)
{
	age = getsubset(varname,tousename)
	r = level*natfer(age) :* exp( -control*confer(age) ) :* pnupt(age,mean,stdev,1)
	putsubset(varname,tousename,r)
}
end

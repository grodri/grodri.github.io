program define _gconfer
*! Coale's schedule of fertility control - GR Apr 2006
version 9
	syntax newvarname=/exp [if] [in] 
	tempvar age touse
	quietly {
		gen byte `touse'=1 `if' `in'
		gen `typlist' `varlist' = `exp' if `touse'==1
		mata: cf("`varlist'","`touse'")
	}
end

mata:
void cf(varname, tousename)
{
	age = getsubset(varname,tousename)
	r = confer(age)
	putsubset(varname,tousename,r)
}
end

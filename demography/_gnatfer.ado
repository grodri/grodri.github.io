program define _gnatfer
*! Henry's natural fertility schedule - GR Apr 2006
version 9
	syntax newvarname=/exp [if] [in] 
	tempvar age touse
	quietly {
		gen byte `touse'=1 `if' `in'
		gen `typlist' `varlist' = `exp' if `touse'==1
		mata: nf("`varlist'","`touse'")
	}
end

mata:
void nf(varname, tousename)
{
	age = getsubset(varname,tousename)
	r = natfer(age)
	putsubset(varname,tousename,r)
}
end

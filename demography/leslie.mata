// Leslie matrix for population projection
// G. Rodríguez /  28feb2017
//
mata:
    real matrix Leslie(real vector L, real vector m) {
        n = length(L)
        M = J(n,n,0)

        // lower diagonal has survivorship ratios
        for (i=1; i < n; i++) {
            M[i+1,i] = L[i+1]/L[i]
        }
         M[n,n-1] = M[n,n] = L[n]/(L[n-1]+L[n])

        // first row has net maternity contributions
        for(i=1; i < n; i++) {
            if(m[i]==0 & m[i+1]==0) continue
                M[1,i] = L[1]*(m[i] + m[i+1]*L[i+1]/L[i])/2
            }
        if (m[n] > 0) M[1,n] = L[1]*m[n]
        return(M)
    }
end

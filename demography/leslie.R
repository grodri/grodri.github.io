#! Leslie matrix for population projection
#! G. Rodríguez /  28feb201
#
Leslie <- function(L, m) {
	n = length(L)
	M = matrix(0, n, n)

	# lower diagonal has survivorship ratios
	for (i in 1:(n-1)) {
		M[i+1,i] <- L[i+1]/L[i]
	}
	 M[n,n-1] <- M[n,n] <- L[n]/(L[n-1] + L[n])

	# first row has net maternity contributions
	for(i in 1:(n-1)) {
		if(m[i] != 0 | m[i+1] != 0) {
			M[1,i] <- L[1] * (m[i] + m[i+1] * L[i+1]/L[i])/2
		}
	}
	if (m[n] > 0) M[1,n] <- L[1] * m[n]
	M
}
// model mortality schedules
// G. Rodríguez  / 24feb2017

// ----------------------------------------------------------------------
// Coale-Demeny nax

mata:

real scalar cdv_nax(m0, sex, age) {
	b = (0.330, 0.045,  2.684, 0.350, 0.053,  2.800, // 1a0 m/f
	     1.352, 1.651, -2.816, 1.361, 1.522, -1,518) // 4a1 m/f
	if(sex != "male" & sex != "female") {
		errprintf("please specify male or female model")
		exit(198)
	}
	if (age != 0 & age != 1) {
		errprintf("please specify age 0 or 1 (for 1a0 or 4a1)")
		exit(198)
	}
	k = 1
	if (age == 1) k = k + 6
	if (sex == "female") k = k + 3
	if (m0 >= 0.107) {
		a = b[k]
	}
	else {
		a = b[k+1] + b[k + 2] * m0
	}
	return(a)
}
	
// ----------------------------------------------------------------------
// log-quadratic model

// return log rates given parameters h and k and model sex
//
real vector logquad(real scalar h, real scalar k, string scalar sex) {
	b = logquad_coef(sex)	
	logm = b[,2] + b[,3] :* h + b[,4] :* h^2 + b[,5] :* k
	m0 = exp(logm[1])
	a0 = cdv_nax(m0, sex, 0)
	a1 = cdv_nax(m0, sex, 1)
	q01 = m0/(1 + (1 - a0) * m0)
	q05 = exp(h)
	q14 = 1 - (1 - q05)/(1 - q01)
	logm[2] = log(q14/(4 - (4 - a1)*q14))
	return(logm)
}

// convert rates to survival given nax's (use CD for first two)
//
real vector logquad_lx(real vector logmx, real vector ax, string scalar sex) {
	mx = exp(logmx)
	n = length(mx)
	ax[1] = cdv_nax(mx[1], sex, 0) 
	ax[2] = cdv_nax(mx[1], sex, 1)
	ax[n] = 1/mx[n]
	w = 1 \ 4 \ J(n, 1, 5)
	q = w :* mx :/ (1 :+ (w - ax) :* mx)
	lx = exp(runningsum(log(1 :- q)))
	return(lx)
}
// return matrix of constants for given sex
//
real matrix logquad_coef(string scalar sex) {
	external logquad_males, logquad_females
	if(sex != "male" & sex != "female") {
		errprintf("please specify male or female model\n")
		exit(198)
	}
	return(sex == "male" ? logquad_males : logquad_females)
	
}

// all model constants, a, b, d and v, males then females
//
logquad_males = (
  0, -0.5101,  0.8164, -0.0245, 0\      
  1,       .,       .,       .,  .\     
  5, -3.0435,  1.5270,  0.0817, 0.1720\ 
 10, -3.9554,  1.2390,  0.0638, 0.1683\ 
 15, -3.9374,  1.0425,  0.0750, 0.2161\ 
 20, -3.4165,  1.1651,  0.0945, 0.3022\ 
 25, -3.4237,  1.1444,  0.0905, 0.3624\ 
 30, -3.4438,  1.0682,  0.0814, 0.3848\ 
 35, -3.4198,  0.9620,  0.0714, 0.3779\ 
 40, -3.3829,  0.8337,  0.0609, 0.3530\ 
 45, -3.4456,  0.6039,  0.0362, 0.3060\ 
 50, -3.4217,  0.4001,  0.0138, 0.2564\ 
 55, -3.4144,  0.1760, -0.0128, 0.2017\ 
 60, -3.1402,  0.0921, -0.0216, 0.1616\ 
 65, -2.8565,  0.0217, -0.0283, 0.1216\ 
 70, -2.4114,  0.0388, -0.0235, 0.0864\ 
 75, -2.0411,  0.0093, -0.0252, 0.0537\ 
 80, -1.6456,  0.0085, -0.0221, 0.0316\ 
 85, -1.3203, -0.0183, -0.0219, 0.0061\ 
 90, -1.0368, -0.0314, -0.0184, 0\      
 95, -0.7310, -0.0170, -0.0133, 0\      
100, -0.5024, -0.0081, -0.0086, 0\      
105, -0.3275, -0.0001, -0.0048, 0\      
110, -0.2212, -0.0028, -0.0027, 0)
logquad_females = (
  0, -0.5101,  0.8164, -0.0245, 0\     
  1,       .,       .,       .,  .\
  5, -2.5608,  1.7937,  0.1082, 0.2788\
 10, -3.2435,  1.6653,  0.1088, 0.3423\
 15, -3.1099,  1.5797,  0.1147, 0.4007\
 20, -2.9789,  1.5053,  0.1011, 0.4133\
 25, -3.0185,  1.3729,  0.0815, 0.3884\
 30, -3.0201,  1.2879,  0.0778, 0.3391\
 35, -3.1487,  1.1071,  0.0637, 0.2829\
 40, -3.2690,  0.9339,  0.0533, 0.2246\
 45, -3.5202,  0.6642,  0.0289, 0.1774\
 50, -3.4076,  0.5556,  0.0208, 0.1429\
 55, -3.2587,  0.4461,  0.0101, 0.1190\
 60, -2.8907,  0.3988,  0.0042, 0.0807\
 65, -2.6608,  0.2591, -0.0135, 0.0571\
 70, -2.2949,  0.1759, -0.0229, 0.0295\
 75, -2.0414,  0.0481, -0.0354, 0.0114\
 80, -1.7308, -0.0064, -0.0347, 0.0033\
 85, -1.4473, -0.0531, -0.0327, 0.0040\
 90, -1.1582, -0.0617, -0.0259, 0\
 95, -0.8655, -0.0598, -0.0198, 0\
100, -0.6294, -0.0513, -0.0134, 0\
105, -0.4282, -0.0341, -0.0075, 0\
110, -0.2966, -0.0229, -0.0041, 0)

end

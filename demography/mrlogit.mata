// model mortality schedules
// G. Rodríguez  / 23feb2017

mata:

// Brass relational logit model
// -----------------------------

// brass logit given survival probabilities
real vector brass_yx(real vector lx) {
  return(-0.5 * logit(lx))
}

// brass survival as function of logit
real vector brass_lx(real vector yx) {
  return(1 :/ (1 :+ exp(2 * yx)))
}

// modified relational logit model
// --------------------------------

// modified logit transformation of survival
real vector mrlogit_zx(real vector lx, string scalar sex) {	
  m = mrlogit_coef(sex)
  if(length(lx) != rows(m)) {
	errprintf("expected lx for ages 1,5(5)85\n")
	exit(198)
  }
  yx = brass_yx(lx)
  ys = brass_yx(m[,4])
  r1  = 1 - yx[2]/ys[2]
  r60 = 1 - yx[13]/ys[13]
  return(yx + m[,2] * r1 + m[,3] * r60)
}

// modified logit standard
real vector mrlogit_zs(string scalar sex) {
    m = mrlogit_coef(sex)
    return(brass_yx(m[,4]))
}

// modified logit fitted survival values
real vector mrlogit_lx(real scalar alpha, real scalar beta, string scalar sex) {
  m = mrlogit_coef(sex)
  ys = brass_yx(m[,4])
  yx = alpha :+ beta * ys
  r1  = 1 - yx[2]/ys[2]
  r60 = 1 - yx[13]/ys[13]
  return(brass_lx(yx - m[,2] * r1 - m[,3] * r60))
}

// gamma, theta and ls schedule
real matrix mrlogit_coef(string scalar sex) {
  external mrlogit_df
  if(sex != "male" & sex != "female") {
	errprintf("specify male or female model")
	exit(198)
  }
  k = 1::18
  if (sex == "female") k = k :+ 18
  return(mrlogit_df[k,])
}

// age, gamma, theta, lx for males, then females (with signs as in paper)
mrlogit_df = (
  1,  0.1607,  -0.0097,  0.9687\
  5,       0,        0,  0.9601\
 10, -0.0325,   0.0025,  0.9567\
 15, -0.0297,   0.0047,  0.9539\
 20,  0.0427,   0.0018,  0.9478\
 25,  0.1262,  -0.0210,  0.9392\
 30,  0.1877,  -0.0518,  0.9301\
 35,  0.2430,  -0.0883,  0.9195\
 40,  0.2899,  -0.1248,  0.9058\
 45,  0.3148,  -0.1482,  0.8865\
 50,  0.2888,  -0.1402,  0.8583\
 55,  0.1915,  -0.0910,  0.8171\
 60,       0,        0,  0.7579\
 65, -0.2304,   0.1170,  0.6749\
 70, -0.5523,   0.2579,  0.5655\
 75, -0.9669,   0.4150,  0.4299\
 80, -1.5013,   0.5936,  0.2812\
 85, -2.2126,   0.8051,  0.1436\
  1,  0.0855,   0.0734, -0.0734\
  5,       0,        0,  0.0000\
 10, -0.0026,  -0.0229,  0.0229\
 15,  0.0291,  -0.0485,  0.0485\
 20,  0.1199,  -0.1090,  0.1090\
 25,  0.1931,  -0.1702,  0.1702\
 30,  0.2352,  -0.2117,  0.2117\
 35,  0.2686,  -0.2408,  0.2408\
 40,  0.3003,  -0.2601,  0.2601\
 45,  0.3203,  -0.2594,  0.2594\
 50,  0.2935,  -0.2183,  0.2183\
 55,  0.1967,  -0.1338,  0.1338\
 60,       0,        0,  0.0000\
 65, -0.2794,   0.1859, -0.1859\
 70, -0.7066,   0.4377, -0.4377\
 75, -1.2835,   0.7534, -0.7534\
 80, -2.0296,   1.1360, -1.1360\
 85, -2.9576,   1.5774, -1.5774)
end

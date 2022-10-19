# model mortality schedules
# G. Rodríguez  / 24feb2017

#! The Coale-Demeny nax's
#------------------------

cdv_nax <- function(m0, sex, age) {
  # Coale-Demeny 1a0 and 4a1
  b <- c(0.330, 0.045,  2.684, 0.350, 0.053,  2.800, # 1a0 m/f
         1.352, 1.651, -2.816, 1.361, 1.522, -1.518) # 4a1 m/f
  if (!sex %in% c("male","female")) stop("specify male or female")
  if (!age %in% c(0,1)) stop("specify age 0 or 1 (for 1a0 or 4a1)")
  k <- 1
  if (age == 1) k <- k + 6
  if (sex == "female") k <- k + 3
  ifelse(m0 >= 0.107, b[k], b[k+1] + b[k+2] * m0)
}


#! The log-quadratic model of Wilmoth et al. 2012
#--------------------------------------------

#! get coefficients for given sex
logquad_coef <- function(sex) {
  if(!sex %in% c("male","female")) {
    stop("please specify male or female model")
  }
  logquad_df[logquad_df$sex == sex, ]
}

#! calculate log-mortality given h and k and sex model
logquad <- function(h, k, sex) {
  m <- logquad_coef(sex)
  logmx <- m$a + m$b * h + m$c * h^2 + m$v * k
  q5 = exp(h)
  mx1 <- exp(logmx[1])
  a1 <- cdv_nax(mx1, sex, 0)
  a4 <- cdv_nax(mx1, sex, 1)
  q1 <- mx1 / (1 + (1 - a1) * mx1)
  q4 <- 1 - (1 - q5)/(1-q1)
  logmx[2] <- log(q4) - log(4 - (4 - a4) * q4)
  a <- seq(5, 105, 5)
  age <- c("0", "1-4", paste(a, a+4, sep="-"), "110+")
  data.frame(age, logmx)
}
text = "
age sex    a       b       c      v
  0 male -0.5101  0.8164 -0.0245 0.0000
  1 male  0       0       0      0
  5 male -3.0435  1.5270  0.0817 0.1720
 10 male -3.9554  1.2390  0.0638 0.1683
 15 male -3.9374  1.0425  0.0750 0.2161
 20 male -3.4165  1.1651  0.0945 0.3022
 25 male -3.4237  1.1444  0.0905 0.3624
 30 male -3.4438  1.0682  0.0814 0.3848
 35 male -3.4198  0.9620  0.0714 0.3779
 40 male -3.3829  0.8337  0.0609 0.3530
 45 male -3.4456  0.6039  0.0362 0.3060
 50 male -3.4217  0.4001  0.0138 0.2564
 55 male -3.4144  0.1760 -0.0128 0.2017
 60 male -3.1402  0.0921 -0.0216 0.1616
 65 male -2.8565  0.0217 -0.0283 0.1216
 70 male -2.4114  0.0388 -0.0235 0.0864
 75 male -2.0411  0.0093 -0.0252 0.0537
 80 male -1.6456  0.0085 -0.0221 0.0316
 85 male -1.3203 -0.0183 -0.0219 0.0061
 90 male -1.0368 -0.0314 -0.0184 0.0000
 95 male -0.7310 -0.0170 -0.0133 0.0000
100 male -0.5024 -0.0081 -0.0086 0.0000
105 male -0.3275  0.0001 -0.0048 0.0000
110 male -0.2212  0.0028 -0.0027 0.0000
  0 female  -0.6619  0.7684 -0.0277 0.0000
  1 female   0       0       0      0
  5 female  -2.5608  1.7937  0.1082 0.2788
 10 female  -3.2435  1.6653  0.1088 0.342
 15 female  -3.1099  1.5797  0.1147 0.400
 20 female  -2.9789  1.5053  0.1011 0.413
 25 female  -3.0185  1.3729  0.0815 0.388
 30 female  -3.0201  1.2879  0.0778 0.339
 35 female  -3.1487  1.1071  0.0637 0.282
 40 female  -3.2690  0.9339  0.0533 0.224
 45 female  -3.5202  0.6642  0.0289 0.177
 50 female  -3.4076  0.5556  0.0208 0.142
 55 female  -3.2587  0.4461  0.0101 0.119
 60 female  -2.8907  0.3988  0.0042 0.080
 65 female  -2.6608  0.2591 -0.0135 0.057
 70 female  -2.2949  0.1759 -0.0229 0.029
 75 female  -2.0414  0.0481 -0.0354 0.011
 80 female  -1.7308 -0.0064 -0.0347 0.003
 85 female  -1.4473 -0.0531 -0.0327 0.0040
 90 female  -1.1582 -0.0617 -0.0259 0.0000
 95 female  -0.8655 -0.0598 -0.0198 0.0000
100 female  -0.6294 -0.0513 -0.0134 0.0000
105 female  -0.4282 -0.0341 -0.0075 0.0000
110 female  -0.2966 -0.0229 -0.0041 0.0000"
logquad_df <- read.table(text = text, header = TRUE)

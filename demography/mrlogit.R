# model mortality schedules
# G. Rodríguez  / 23feb2017

#! Brass relational logit model
# -----------------------------

#! brass logit given survival probabilities
brass_yx <- function(lx) {
  -0.5 * qlogis(lx)
}

#! brass survival as function of logit
brass_lx <- function(yx) {
  1/(1 + exp(2 * yx))
}

#! modified relational logit model
# --------------------------------

#! modified logit transformation of survival
mrlogit_zx <- function(lx, sex) {
  m <- mrlogit_coef(sex)
  if(length(lx) != nrow(m)) stop("expected lx for ages 1,5(5)85")
  yx <- brass_yx(lx)
  ys <- brass_yx(m$lx)
  r1  = 1 - yx[m$age ==  5]/ys[m$age == 5]
  r60 = 1 - yx[m$age == 60]/ys[m$age == 60]
  yx + m$gamma * r1 + m$theta * r60
}

#! modified logit standard
mrlogit_zs <- function(sex) {
    m <- mrlogit_coef(sex)
    brass_yx(m$lx)
}

#! modified logit fitted survival values
mrlogit_lx <- function(alpha, beta, sex) {
  m <- mrlogit_coef(sex)
  ys <- brass_yx(m$lx)
  yx <- alpha + beta * ys
  r1  = 1 - yx[m$age ==  5]/ys[m$age ==  5]
  r60 = 1 - yx[m$age == 60]/ys[m$age == 60]
  brass_lx(yx - m$gamma * r1 - m$theta * r60)
}

#! gamma, theta and ls schedule
mrlogit_coef <- function(sex) {
  if(!sex %in% c("male", "female")) stop("specify male or female model")
  mrlogit_df[mrlogit_df$sex == sex, ]
}
#! data
text = "
      sex age   gamma   theta      lx
1    male   1  0.1607 -0.0097  0.96870
2    male   5  0.0000  0.0000  0.96010
3    male  10 -0.0325  0.0025  0.95666
4    male  15 -0.0297  0.0047  0.95385
5    male  20  0.0427  0.0018  0.94782
6    male  25  0.1262 -0.0210  0.93915
7    male  30  0.1877 -0.0518  0.93007
8    male  35  0.2430 -0.0883  0.91949
9    male  40  0.2899 -0.1248  0.90575
10   male  45  0.3148 -0.1482  0.88645
11   male  50  0.2888 -0.1402  0.85834
12   male  55  0.1915 -0.0910  0.81713
13   male  60  0.0000  0.0000  0.75792
14   male  65 -0.2304  0.1170  0.67493
15   male  70 -0.5523  0.2579  0.56546
16   male  75 -0.9669  0.4150  0.42989
17   male  80 -1.5013  0.5936  0.28117
18   male  85 -2.2126  0.8051  0.14364
19 female   1  0.0855  0.0734  0.97455
20 female   5  0.0000  0.0000  0.96651
21 female  10 -0.0026 -0.0229  0.96370
22 female  15  0.0291 -0.0485  0.96153
23 female  20  0.1199 -0.1090  0.95795
24 female  25  0.1931 -0.1702  0.95340
25 female  30  0.2352 -0.2117  0.94824
26 female  35  0.2686 -0.2408  0.94197
27 female  40  0.3003 -0.2601  0.93370
28 female  45  0.3203 -0.2594  0.92220
29 female  50  0.2935 -0.2183  0.90569
30 female  55  0.1967 -0.1338  0.88159
31 female  60  0.0000  0.0000  0.84679
32 female  65 -0.2794  0.1859  0.79481
33 female  70 -0.7066  0.4377  0.71763
34 female  75 -1.2835  0.7534  0.60358
35 female  80 -2.0296  1.1360  0.44958
36 female  85 -2.9576  1.5774  0.27123"
mrlogit_df <- read.table(text = text)

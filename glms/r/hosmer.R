hosmer <- function(y, fv, groups=10, table=TRUE, type=2) {
# A simple implementation of the Hosmer-Lemeshow test
  q <- quantile(fv, seq(0,1,1/groups), type=type)
  fv.g <- cut(fv, breaks=q, include.lowest=TRUE)
  obs <- xtabs( ~ fv.g + y)
  fit <- cbind( e.0 = tapply(1-fv, fv.g, sum), e.1 = tapply(fv, fv.g, sum))
  if(table) print(cbind(obs,fit))  
  chi2 <- sum((obs-fit)^2/fit)
  pval <- pchisq(chi2, groups-2, lower.tail=FALSE)
  data.frame(test="Hosmer-Lemeshow",groups=groups,chi.sq=chi2,pvalue=pval)
}
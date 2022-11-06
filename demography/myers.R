# Myers <grodri@princeton.edu>

myers <- function(data, age, weight, limits=NULL, months=FALSE) {
  require(dplyr)
  unit = 10
  if(months) unit = 12
  
  # get data
  d <- data.frame(
    x = eval(substitute(age), data),
    w = eval(substitute(weight), data))

  # determine limits
  r <- range(d$x)
  bot <- r[1]
  top <- r[2] - unit
  if(!is.null(limits)) {
      bot <- limits[1]
      top <- limits[2]
      if(bot < r[1] | top > r[2]) {
        stop("Limits extend outside range of data")
      }
      if( (top - bot + 1) %% unit > 0.01) {
        stop(paste("limits should represent a multiple of", unit))
      }
  }
  else if( (r[2] - r[1] + 1) %% unit > 0.01) {
    stop(paste("define limits, as range is not a multiple of",unit))
  }

  # compute last digit and weights
  d <- mutate(d, 
    digit = x %% unit,
    m  = ifelse(x < bot + unit, x - bot + 1,
         ifelse(x > top, top + unit - x, unit)))
  d$m[d$x < bot | d$x > top + unit - 1] <- 0
  
  # tabulate
  total = sum(d$w * d$m)
  table <- group_by(d, digit) %>%
    summarize(freq = sum(w*m), pct = 100*freq/total)
  mi <- sum(abs(table$pct - 100/unit))/2
  if(top + unit -1 > r[2]) {
    attr(mi,"note") <- paste("(Assuming no observations above ",r[2],")",sep="")
  }
  attr(mi, "table") <- data.frame(table)
  class(mi) <- "myers"
  mi
}

print.myers <- function(obj) {
  cat("\nMyers' blended index =",round(obj, 2),"\n")
  note <- attr(obj,"note")
  if(!is.null(note)) cat(note)
}
summary.myers <- function(obj) {
  cat("\nMyers's blended frequencies\n")
  print(attr(obj,"table"))
  print(obj)
  invisible(NULL)
}
plot.myers <- function(obj, ...) {
  data <- attr(obj, "table")
  barplot(data$pct-10, names.arg=data$digit, ...)
  invisible(NULL)
}
# in ggplot:
#ggplot(data, aes(digit, weight=pct-10)) + geom_bar(fill="#3366cc")

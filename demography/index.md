---
layout: default
section: demography
tab: Home
toc: true
---

<div class="lead"><small>
This section has course materials from Pop 502: Research Methods in Demography, as
offered in the Spring of 2017. The course was cross-listed as Eco 572 and
Soc 532. The registrar's course page is
<a href="https://registrar.princeton.edu/course-offerings/course_details.xml?term=1174&courseid=001472">here</a>
</small></div>

<button type="button" class="btn btn-default pull-right" data-toggle="collapse"
data-target="#toc">Table of Contents</button>

## Course Materials

The site has a collection of computing handouts, showing how to use Stata and R 
(with `dplyr` and `ggplot2`) in demographic analysis. Click on the Table of Contents
for direct access to the logs, or see the descriptions below.  The syllabus for 
Spring 2017 [is here](Pop502SyllabusSpring2017.pdf). The class handouts originally 
on Blackboard are now [available here](handouts).

#### 1. Rates and Standardization

Here's a computing handout on [Growth Rates and Doubling Time](grdt),
the topic of the first class, followed by one on [Rates and
Standardization](std), where we discuss direct and indirect
standardization and the decomposition of differences in rates, the
subjects of our second meeting.

#### 2. Interpolation and Graduation

On week 2 we start with [age heaping and Myer's index](digitpref)
before we enter the wonderful world of splines. To learn about running
means, running lines, and all sorts of splines, read the first 6 pages
of a statistical demography handout on ![](/images/pdficon_small.png)
[Smoothing and Non-Parametric Regression](smoothing.pdf). The
applications start with [running means and lines](smoothing1), including
the `lowess` smoother, and continue with [regression
splines](smoothing2) and [spline interpolation](interpolation).

#### 3. Life Tables

We start week 3 with a review of life tables, and a handout on [period
life table construction](periodlt). We have an illustration of [Brass's
relational logit](relationalLogit) model, and another fitting the
[modified logit and log-quadratic](mortmods) models.

#### 4. Survival

How fast do we age? We fit a Gompertz curve to [adult mortality in the
U.S.](us2002gompertz). We work with male survival and invite you to do
the same calculations for females. We also discuss the
[Kaplan-Meir](KaplanMeier) estimate of a survival curve from censored
data, and an application of [Cox regression](CoxModel) to the cancer
relapse data we used for Kaplan-Meier.

#### 5. Unobserved Heterogeneity

The handout on ![](/images/pdficon_small.png) [unobserved
heterogeneity](unobservedHeterogeneity.pdf) provides a summary of the
main ideas. (A more detailed discussion may be found on an earlier
statistical demography [handout](/pop509/unobservedHeterogeneity.pdf);
focus on gamma heterogeneity and the inversion formula). The
illustration deals with [heterogeneity and mortality
cross-overs](heterogeneity).

#### 6. Competing Risks

We go over the example in the textbook working with [multiple-decrement
and cause-deleted](neoplasms) life tables, including a simplified
approach that assumes constant risks within each age group. We
illustrate increment-decrement life tables using a classic dataset on
[contraceptive discontinuation](tietze).

#### 7. Nuptiality

Spring is in the air and we turn to a study of marrriage. The handout
covers [current status life tables](cstatus), with applications to
nuptiality and duration of breastfeeding. And here's the application of
the [Coale-McNeil and Hernes models of marriage](nuptiality).

#### 8. Fertility Rates

We start our study of fertility by computing [age-specific fertility
rates](asfr) from survey data using an exact and an approximate method.
We fit [Coale's model](brostrom) of marital fertility by age to the
data in Brostrom's paper. We then apply [Page's model](page) to study
fertility by age and duration since first union in urban and rural
areas.

#### 9. Birth Intervals

Here's a [bith intervals analysis](cobint) of the transition from
second to third birth in Colombia in 1976 by childhood place of
residence. I include illustrative computations of quintums and trimeans
and, for good measure, a proportional hazards model.

#### 10. Tempo Effects

To provide some background for our discussion of tempo effects on
fertility and mortality, here's an analysis of [U.S. fertility
1917-1980](heuser), including an application of Ryder's translation
formula and the Bongaarts-Feeney tempo adjustment.

#### 11. Population Projections

The handouts include an application of the [cohort component
method](project) to the Swedish data in the textbook using a Leslie
matrix, and an examination of key aspects of the [Lee-Carter](LeeCarter)
approach to forecasting mortality, with an application of the singular
value decomposition to U.S. data for 1933-1987 and a simulation of
stochastic forecasts.

#### 12. Stable Populations

We come to a close with two handouts on stable populations. The first
deals with computing [Lotka's r and the stable equivalent age
distribution](stablepop), following the examples in Boxes 7.1 and 7.2 in
the textbook. The second deals with the estimation of [population
momentum](momentum) using the Preston-Guillot method illustrated in Box
7.3 of the textbook and, as a comparison, Keyfitz's formula.

{% include markstat.md %}

<small>Updated Fall 2022</small>

{% include toc.html %}
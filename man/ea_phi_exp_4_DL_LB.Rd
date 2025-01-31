% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{ea_phi_exp_4_DL_LB}
\alias{ea_phi_exp_4_DL_LB}
\title{Obtain the global lower bound for phi function}
\usage{
ea_phi_exp_4_DL_LB(mean, beta, precondition)
}
\arguments{
\item{mean}{mean value}

\item{beta}{beta value}

\item{precondition}{precondition value}
}
\value{
The global lower bound of phi
}
\description{
Finds the global bound of the phi function between a given interval
}
\examples{
mu <- 0.435
beta <- 0.583
precondition <- 1.243
lower <- 0
upper <- 1.6

curve(ea_phi_exp_4_DL(x, mu, beta, precondition), lower, upper, ylab = 'phi')
abline(v=c(lower, upper))
abline(h=ea_phi_exp_4_DL_LB(mean = mu,
                            beta = beta,
                            precondition = precondition))
abline(h=ea_phi_exp_4_DL_bounds(mean = mu,
                                beta = beta,
                                lower = lower,
                                upper = upper,
                                precondition = precondition), 
      col = 'red', lty = 2)
}

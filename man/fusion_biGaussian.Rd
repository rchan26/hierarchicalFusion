% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bivariate_Gaussian_fusion.R
\name{fusion_biGaussian}
\alias{fusion_biGaussian}
\title{Generalised Monte Carlo Fusion (rejection sampling) [on a single core]}
\usage{
fusion_biGaussian(
  N,
  m,
  time,
  samples_to_fuse,
  mean_vec,
  sd_vec,
  corr,
  betas,
  precondition_matrices,
  inv_precondition_matrices
)
}
\arguments{
\item{N}{number of samples}

\item{m}{number of sub-posteriors to combine}

\item{time}{time T for fusion algorithm}

\item{samples_to_fuse}{list of length m, where samples_to_fuse[c] containing
the samples for the c-th sub-posterior}

\item{mean_vec}{vector of length 2 for mean}

\item{sd_vec}{vector of length 2 for standard deviation}

\item{corr}{correlation value between component 1 and component 2}

\item{betas}{vector of length m, where betas[c] is the inverse temperature (beta)
for c-th sub-posterior (can also pass in one number if they are all
at the same inverse temperature)}

\item{precondition_matrices}{list of length m, where precondition_matrices[[c]]
is the precondition matrix for sub-posterior c}
}
\value{
samples: fusion samples

iters_rho: number of iterations from the first accept/reject step (rho)

iters_Q: number of iterations from the second (diffusion) accept/reject step (Q)
}
\description{
Generalised Monte Carlo Fusion with bivariate Gaussian target
}

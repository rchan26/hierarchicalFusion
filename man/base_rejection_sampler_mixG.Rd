% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mixG_sampler.R
\name{base_rejection_sampler_mixG}
\alias{base_rejection_sampler_mixG}
\title{Rejection sampler for base level}
\usage{
base_rejection_sampler_mixG(
  nsamples,
  weights,
  means,
  sds,
  beta,
  proposal_sds,
  dominating_M
)
}
\arguments{
\item{nsamples}{number of samples per node}

\item{weights}{vector: weights of mixture Gaussian}

\item{means}{vector: means of mixture Gassuan}

\item{sds}{vector: st.devs of mixture Gaussian}

\item{beta}{real value between 0 and 1}

\item{proposal_sds}{vector: st.devs of proposal mixture Gaussian}

\item{dominating_M}{constant M to bound the target density}
}
\value{
list of length (1/beta) with samples from tempered mixture Gaussian
}
\description{
Sample for base level tempered mixture Gaussian
}

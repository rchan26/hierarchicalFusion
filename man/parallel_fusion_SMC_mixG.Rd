% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mixG_fusion.R
\name{parallel_fusion_SMC_mixG}
\alias{parallel_fusion_SMC_mixG}
\title{Generalised Monte Carlo Fusion [parallel]}
\usage{
parallel_fusion_SMC_mixG(
  particles_to_fuse,
  N,
  m,
  time,
  n_comp,
  weights,
  means,
  sds,
  betas,
  precondition_values,
  bounds_multiplier = 1.1,
  resampling_method = "multi",
  ESS_threshold = 0.5,
  seed = NULL,
  n_cores = parallel::detectCores()
)
}
\arguments{
\item{particles_to_fuse}{list of length m, where particles_to_fuse[[c]]
contains the particles for the c-th sub-posterior
(a list of particles to fuse can be initialised by 
initialise_particle_sets() function)}

\item{N}{number of samples}

\item{m}{number of sub-posteriors to combine}

\item{time}{time T for fusion algorithm}

\item{n_comp}{integer number of components of mixture Gaussian}

\item{weights}{vector: weights of mixture Gaussian}

\item{means}{vector: means of mixture Gaussian}

\item{sds}{vector: st.devs of mixture Gaussian}

\item{betas}{vector of length c, where betas[c] is the inverse temperature 
value for c-th posterior}

\item{precondition_values}{vector of length m, where precondition_values[c]
is the precondition value for sub-posterior c}

\item{bounds_multiplier}{scalar value to multiply bounds by 
(should greater than or equal to 1)}

\item{resampling_method}{method to be used in resampling, default is multinomial 
resampling ('multi'). Other choices are stratified 
resampling ('strat'), systematic resampling ('system'),
residual resampling ('resid')}

\item{ESS_threshold}{number between 0 and 1 defining the proportion 
of the number of samples that ESS needs to be
lower than for resampling (i.e. resampling is carried 
out only when ESS < N*ESS_threshold)}

\item{seed}{seed number - default is NULL, meaning there is no seed}

\item{n_cores}{number of cores to use}
}
\value{
A list with components:
\describe{
  \item{particles}{particles returned from fusion sampler}
  \item{proposed_samples}{proposal samples from fusion sampler}
  \item{time}{run-time of fusion sampler}
  \item{ESS}{effective sample size of the particles after each step}
  \item{CESS}{conditional effective sample size of the particles after each step}
  \item{resampled}{boolean value to indicate if particles were resampled
                   after each time step}
  \item{precondition_values}{list of length 2 where precondition_values[[2]] 
                             are the pre-conditioning values that were used 
                             and precondition_values[[1]] are the combined 
                             precondition values}
}
}
\description{
Generalised Monte Carlo Fusion with mixture Gaussian target
}

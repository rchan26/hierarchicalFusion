% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/importance_sampling_functions.R
\name{rho_IS_univariate}
\alias{rho_IS_univariate}
\title{rho Importance Sampling Step (univariate)}
\usage{
rho_IS_univariate(
  particles_to_fuse,
  N,
  m,
  time,
  precondition_values,
  number_of_steps = 2,
  time_mesh = NA,
  resampling_method = "multi",
  seed = NULL,
  n_cores = parallel::detectCores(),
  cl = NULL
)
}
\arguments{
\item{particles_to_fuse}{list of length m, where particles_to_fuse[[c]]
contains the particles for the c-th sub-posterior
(a list of particles to fuse can be initialised by
initialise_particle_sets() function)}

\item{N}{number of particles to importance sample}

\item{m}{number of sub-posteriors to combine}

\item{time}{end time T for fusion algorithm}

\item{precondition_values}{vector of length m, where precondition_values[[c]]
is the precondition value for sub-posterior c}

\item{number_of_steps}{integer value for number of steps in the Fusion algorithm
(default is 2 for Monte Carlo Fusion)}

\item{time_mesh}{vector of times used in Fusion algorithm (default is NA). If
set to NA, the returned particle has time_mesh given by c(0, time)}

\item{resampling_method}{method to be used in resampling, default is multinomial 
resampling ('multi'). Other choices are stratified 
resampling ('strat'), systematic resampling ('system'),
residual resampling ('resid')}

\item{seed}{seed number - default is NULL, meaning there is no seed}

\item{n_cores}{number of cores to use}

\item{cl}{an object of class "cluster" for parallel computation in R. If none
is passed, then one is created and used within this function}
}
\value{
A importance weighted particle set
}
\description{
Performs the importance sampling step for rho where target is univariate
}
\examples{
samples_to_fuse <- lapply(1:2, function(i) rnorm(100, 0, 1))
particles_to_fuse <- initialise_particle_sets(samples_to_fuse = samples_to_fuse,
                                              multivariate = FALSE)
precondition_values <- sapply(samples_to_fuse, var)
particles <- rho_IS_univariate(particles_to_fuse = particles_to_fuse,
                               N = 100,
                               m = 2,
                               time = 0.5,
                               precondition_values = precondition_values)

}

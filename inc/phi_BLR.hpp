#ifndef PHI_BLR
#define PHI_BLR

#include <RcppArmadillo.h>

arma::vec log_BLR_gradient(const arma::vec &beta,
                           const arma::vec &y_labels,
                           const arma::mat &X,
                           const arma::vec &X_beta,
                           const arma::vec &count,
                           const arma::vec &prior_means,
                           const arma::vec &prior_variances,
                           const double &C);

arma::mat log_BLR_hessian(const arma::mat &X,
                          const arma::vec &X_beta,
                          const arma::vec &count,
                          const arma::vec &prior_variances,
                          const double &C);

Rcpp::List ea_phi_BLR_DL_vec(const arma::vec &beta,
                             const arma::vec &y_labels,
                             const arma::mat &X,
                             const arma::vec &count,
                             const arma::vec &prior_means,
                             const arma::vec &prior_variances,
                             const double &C,
                             const arma::mat &precondition_mat);

Rcpp::List ea_phi_BLR_DL_matrix(const arma::mat &beta,
                                const arma::vec &y_labels,
                                const arma::mat &X,
                                const arma::vec &count,
                                const arma::vec &prior_means,
                                const arma::vec &prior_variances,
                                const double &C,
                                const arma::mat &precondition_mat);

double spectral_radius_BLR(const arma::vec &beta,
                           const arma::mat &X,
                           const arma::vec &count,
                           const arma::vec &prior_variances,
                           const double &C,
                           const arma::mat &Lambda);

Rcpp::List obtain_hypercube_centre_BLR(const Rcpp::List &bessel_layers,
                                       const arma::mat &transform_to_X,
                                       const arma::vec &y_labels,
                                       const arma::mat &X,
                                       const arma::vec &count,
                                       const arma::vec &prior_means,
                                       const arma::vec &prior_variances,
                                       const double &C);

Rcpp::List spectral_radius_bound_BLR_Z(const int &dim,
                                       const Rcpp::List &bessel_layers,
                                       const arma::vec &z_hat,
                                       const arma::mat &transformed_X,
                                       const arma::vec &count,
                                       const arma::vec &prior_variances,
                                       const double &C,
                                       const arma::mat &sqrt_Lambda);

Rcpp::List spectral_radius_global_bound_BLR_Z(const int &dim,
                                              const arma::mat &transformed_X,
                                              const arma::vec &count,
                                              const arma::vec &prior_variances,
                                              const double &C,
                                              const arma::mat &sqrt_Lambda);

Rcpp::List ea_phi_BLR_DL_bounds(const arma::vec &beta_hat,
                                const arma::vec &grad_log_hat,
                                const arma::vec &hypercube_centre_Z,
                                const int &dim,
                                const arma::mat &transformed_X,
                                const arma::vec &count,
                                const arma::vec &prior_variances,
                                const double &C,
                                const Rcpp::List &transform_mats,
                                const Rcpp::List &hypercube_vertices,
                                const Rcpp::List &bessel_layers,
                                const bool &local_bounds,
                                const bool &hypercube_centre);

double gamma_NB_BLR(const arma::vec &times,
                    const double &h,
                    const arma::vec &x0,
                    const arma::vec &y,
                    const double &s,
                    const double &t,
                    const arma::vec &y_labels,
                    const arma::mat &X,
                    const arma::vec &count,
                    const arma::vec &prior_means,
                    const arma::vec &prior_variances,
                    const double &C,
                    const arma::mat &precondition_mat);

#endif
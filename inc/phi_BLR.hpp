#ifndef PHI_BLR
#define PHI_BLR

#include <RcppArmadillo.h>

arma::vec log_BLR_gradient(const arma::vec &beta,
                           const arma::vec &y_labels,
                           const arma::mat &X, 
                           const arma::vec &X_beta,
                           const arma::vec &prior_means,
                           const arma::vec &prior_variances,
                           const double &C);

double div_log_BLR_gradient(const arma::mat &X, 
                            const arma::vec &X_beta,
                            const arma::vec &prior_variances,
                            const double &C,
                            const arma::mat &precondition_mat);

double ea_phi_BLR_DL(const arma::vec &beta,
                     const arma::vec &y_labels,
                     const arma::mat &X, 
                     const arma::vec &prior_means,
                     const arma::vec &prior_variances,
                     const double &C,
                     const arma::mat &precondition_mat, 
                     const arma::mat &transform_mat);

double ea_phi_BLR_DL_LB(const arma::mat &X,
                        const arma::vec &prior_variances,
                        const double &C,
                        const arma::mat &precondition_mat);

#endif
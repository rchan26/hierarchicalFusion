library(DCFusion)

seed <- 408
denominator <- 2:16
input_samples <- list()
fnj_results <- list()
bal_results <- list()
prog_results <- list()
time_choice <- 1

for (i in 1:length(denominator)) {
  print(denominator[i])
  set.seed(seed)
  input_samples[[i]] <- base_rejection_sampler_exp_4(beta = 1/denominator[i],
                                                     nsamples = 10000,
                                                     proposal_mean = 0,
                                                     proposal_sd = 1.5,
                                                     dominating_M = 1.75)
  
  curve(exp_4_density(x, beta = 1/denominator[i]), -4, 4,
        main = denominator[i], ylab = 'tempered pdf')
  for (j in 1:length(input_samples[[i]])) {
    lines(density(input_samples[[i]][[j]]), col = 'black')
  }
  
  # standard fork and join
  print('performing standard fork-and-join MC fusion')
  fnj_fused <- bal_binary_fusion_exp_4(N_schedule = 10000,
                                       m_schedule = denominator[i],
                                       time_schedule = time_choice,
                                       base_samples = input_samples[[i]],
                                       mean = 0,
                                       start_beta = 1/denominator[i],
                                       L = 2,
                                       precondition = FALSE,
                                       seed = seed)
  
  fnj_results[[i]] <- list('time' = fnj_fused$overall_time,
                           'overall_rho' = fnj_fused$overall_rho,
                           'overall_Q' = fnj_fused$overall_Q,
                           'overall_rhoQ' = fnj_fused$overall_rhoQ)
  
  # balanced binary if denominator[i] is 2, 4, 8, or 16
  if (denominator[i]==2) {
    print('performing standard balanced binary MC fusion')
    bal_fused <- bal_binary_fusion_exp_4(N_schedule = 10000,
                                         m_schedule = 2,
                                         time_schedule = time_choice,
                                         base_samples = input_samples[[i]],
                                         mean = 0,
                                         start_beta = 1/2,
                                         L = 2,
                                         precondition = FALSE,
                                         seed = seed)
  } else if (denominator[i]==4) {
    print('performing standard balanced binary MC fusion')
    bal_fused <- bal_binary_fusion_exp_4(N_schedule = rep(10000, 2),
                                         m_schedule = rep(2, 2),
                                         time_schedule = rep(time_choice, 2),
                                         base_samples = input_samples[[i]],
                                         mean = 0,
                                         start_beta = 1/4,
                                         L = 3,
                                         precondition = FALSE,
                                         seed = seed)
  } else if (denominator[i]==8) {
    print('performing standard balanced binary MC fusion')
    bal_fused <- bal_binary_fusion_exp_4(N_schedule = rep(10000, 3),
                                         m_schedule = rep(2, 3),
                                         time_schedule = rep(time_choice, 3),
                                         base_samples = input_samples[[i]],
                                         mean = 0,
                                         start_beta = 1/8,
                                         L = 4,
                                         precondition = FALSE,
                                         seed = seed)
  } else if (denominator[i]==16) {
    print('performing standard balanced binary MC fusion')
    bal_fused <- bal_binary_fusion_exp_4(N_schedule = rep(10000, 4),
                                         m_schedule = rep(2, 4),
                                         time_schedule = rep(time_choice, 4),
                                         base_samples = input_samples[[i]], 
                                         mean = 0,
                                         start_beta = 1/16,
                                         L = 5,
                                         precondition = FALSE,
                                         seed = seed)
  }
  
  if (denominator[i] %in% c(2, 4, 8, 16)) {
    bal_results[[i]] <- list('time' = bal_fused$overall_time,
                             'overall_rho' = bal_fused$overall_rho,
                             'overall_Q' = bal_fused$overall_Q,
                             'overall_rhoQ' = bal_fused$overall_rhoQ)
  } else {
    bal_results[[i]] <- NA
  }
  
  # progressive
  print('performing standard progressive MC fusion')
  prog_fused <- progressive_fusion_exp_4(N_schedule = rep(10000, denominator[i]-1),
                                         time_schedule = rep(time_choice, denominator[i]-1),
                                         base_samples = input_samples[[i]], 
                                         mean = 0,
                                         start_beta = 1/denominator[i],
                                         precondition = FALSE,
                                         seed = seed)
  
  prog_results[[i]] <- list('time' = prog_fused$time,
                            'overall_rho' = prog_fused$rho_acc,
                            'overall_Q' = prog_fused$Q_acc,
                            'overall_rhoQ' = prog_fused$rhoQ_acc)
  
  curve(exp_4_density(x), -4, 4, ylim = c(0, 0.5), main = denominator[i])
  lines(density(fnj_fused$samples[[1]]), col = 'orange', lty = 2)
  if (!any(is.na(bal_results[[i]]))) {
    lines(density(bal_fused$samples[[1]]), col = 'blue', lty = 2)
  }
  lines(density(prog_fused$samples[[1]]), col = 'darkgreen', lty = 2)
}

plot(x = denominator, y = sapply(1:15, function(i) log(fnj_results[[i]]$time, 2)),
     ylim = c(0, 16), ylab = '', xlab = '', font.lab = 2, pch = 4, lwd = 3, xaxt = 'n', yaxt = 'n', type = 'b')
axis(1, at = denominator, labels = denominator, font = 2, cex = 1.5)
mtext('Number of sub-posteriors (C)', 1, 2.75, font = 2, cex = 1.5)
axis(2, at = seq(0, 20, 2), labels = seq(0, 20, 2), font = 2, cex = 1.5)
axis(2, at=seq(0, 20, 1), labels=rep("", 21), lwd.ticks = 0.5)
mtext('log(Time elapsed in seconds, 2)', 2, 2.75, font = 2, cex = 1.5)

plot(x = denominator, y = sapply(1:15, function(i) fnj_results[[i]]$overall_rho), ylim = c(0, 1),
     ylab = '', xlab = '', col = 'black', pch = 4, lty = 2, lwd = 3, type = 'b', xaxt = 'n', yaxt = 'n')
lines(x = denominator, y = sapply(1:15, function(i) fnj_results[[i]]$overall_Q), 
      col = 'black', pch = 1, lty = 3, lwd = 3, type = 'b')
axis(1, at = denominator, labels = denominator, font = 2, cex = 1.5)
mtext('Number of sub-posteriors (C)', 1, 2.75, font = 2, cex = 1.5)
axis(2, at=seq(0, 1, 0.1), labels=c("0.0", c(seq(0.1, 0.9, 0.1), "1.0")), font = 2, cex = 1.5)
mtext('Acceptance Probability', 2, 2.75, font = 2, cex = 1.5)
legend(x = 2, y = 1,
       legend = c(expression(rho^bm), expression(Q^bm)),
       lwd = c(3, 3),
       lty = c(2, 3),
       pch = c(4, 1),
       cex = 1.25,
       text.font = 2,
       bty = 'n')

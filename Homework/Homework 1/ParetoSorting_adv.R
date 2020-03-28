ParetoSorting_adv <- function(argument1,argument2){
  # This function determines which alternatives (or solutions) are dominated and non-dominated  
  # Args:
  # argument1: N x M matrix with N alternatives (rows) and M objectives (columns)
  # argument2: String that specifies whether we are dealing with a max ("MAX") or min ("MIN") problem
  #
  # Returns:
  # P_prime: boolean vector with N entries--1 means that a solution is dominated; 0 means that the solution is not dominated (so it is Pareto-efficient). 
  # 
  
  # Number of alternatives (or solutions)
  N <- nrow(argument1)
  # Number of objectives
  M <- ncol(argument1)
  # Check whether we have a max or min problem. If MIN, convert to MAX
  if (argument2 == "MIN") argument1 <- -argument1
  
  is_dominated <- function(i) {
      # Function to check if solution i is dominated by any other solutions
      check <- 0
      for (j in setdiff(1:N, i)) {
          #   j is at least equal to i in all obj  & j is better than i for at least one obj
          if (all(argument1[j,] >= argument1[i, ]) && any(argument1[j, ] > argument1[i, ])) {
              check <- 1
              break
          }
      }
      return(check)
  }
  
  # Identify the dominated/non-dominated solutions (MAX)
  P_prime <- sapply(1:N, is_dominated)
  
  # Return the output of function ParetoSorting
  return(P_prime)
}
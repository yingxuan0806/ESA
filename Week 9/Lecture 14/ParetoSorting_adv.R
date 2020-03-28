ParetoSorting_adv <- function(argument1,argument2){
  # This function determines which alternatives (or solutions) are dominated and non-dominated  
  # Args:
  # argument1: N x M matrix with N alternatives (rows) and M objectives (columns)
  # argument2: String that specifies whether we are dealing with a max ("MAX") or min ("MIN") problem
  #
  # Returns:
  # P_prime: boolean vector with N entries--1 means that a solution is dominated; 0 means that the solution is not dominated. 
  # 
  
  # Get the dimension of the input data
  dimension <- dim(argument1)
  # Number of alternatives (or solutions)
  N <- dimension[1]
  # Number of objectives
  M <- dimension[2]
  
  # Initialize a vector to categorize the alternatives (depending on whether they are dominated or not)
  P_prime <- rep(0,times=N)
  
  # Check whether we have a max or min problem
  if (argument2 == "MAX"){
  
  # For loop to identify the dominated/non-dominated solutions (MAX)
  for (i in 1:N){
    for (j in 1:N){
      if (j != i){
        # Check if solution j (semi)dominates solution i
        test <- rep(0,times=M)
        for (k in 1:M){
          temp <- (argument1[j,k] >= argument1[i,k])
          if (temp == "TRUE") temp <- 1 else temp <- 0
          test[k] <- temp
        }
        if (sum(test) == M){
          P_prime[i] <- 1
          break
        }
      }
    }
  }
  }
    else {
      # For loop to identify the dominated/non-dominated solutions (MIN)
      for (i in 1:N){
        for (j in 1:N){
          if (j != i){
            # Check if solution j (semi)dominates solution i
            test <- rep(0,times=M)
            for (k in 1:M){
              temp <- (argument1[j,k] <= argument1[i,k])
              if (temp == "TRUE") temp <- 1 else temp <- 0
              test[k] <- temp
            }
            if (sum(test) == M){
              P_prime[i] <- 1
              break
            }
          }
        }
      }
  }
  
  # Return the output of function ParetoSorting
  return(P_prime)
}
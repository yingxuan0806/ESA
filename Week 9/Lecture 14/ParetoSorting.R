ParetoSorting <- function(argument1){
  # This function determines which alternatives (or solutions) are dominated and non-dominated  
  # Args:
  # argument1: N x 2 matrix with N alternatives (rows) and 2 objectives (columns)
  #
  # Returns:
  # P_prime: boolean vector with N entries--1 means that a solution is dominated; 0 means that the solution is not dominated. 
  #
  # Note: the function is based on the assumption that all objectives are maximized
  
  # Get the dimension of the input data
  dimension <- dim(argument1)
  # Number of alternatives (or solutions)
  N <- dimension[1]
  # Number of objectives
  # M <- dimension[2]
  
  # Initialize a vector to categorize the alternatives (depending on whether they are dominated or not)
  P_prime <- rep(0,times=N)
  
  # For loop to identify the dominated/non-dominated solutions
  for (i in 1:N){
    for (j in 1:N){
      if (j != i){
        # Check if solution j (semi)dominates solution i
        if (argument1[j,1] >= argument1[i,1] & argument1[j,2] >= argument1[i,2]){
          P_prime[i] <- 1
          break
        }
      }
    }
    }
    
  # Return the output of function ParetoSorting
  return(P_prime)
}
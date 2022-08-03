#' @title Compute the final value of an investment project.
#' 
#' @description Function computing the final of an investment project.
#' 
#' @param n_per Number of periods (years) over which the final value should be 
#' calculated.
#' 
#' @param v_0 Initial investment capital.
#' 
#' @param exp_return Average expected return per year (in percent).
#' 
#' @param x_yearly Yearly annuity. Default = 0.
#' 
#' @param immediate If TRUE, immediate annuities (1st annuity on the 1st of January). 
#' Otherwise, ordinary annuities (1st annuity on the 31st of December).
#' 
#' @return
#' - `FINAL_VALUE`: Investment final value time serie.
#' 
#' @examples
#' # Final value of immediate annuities with first capital and yearly expected of
#' # 10% during 30 years.
#' get_final_value( 
#' n_per = 30,
#' v_0 = 5000, 
#' exp_return = 10, 
#' x_yearly = 12000, 
#' immediate = TRUE
#' )
#'
#' @author [Layal Christine Lettry](mailto:layal.lettry@gmail.com)
#' 
#' @export

get_final_value <- function(
    n_per,
    v_0,
    exp_return,
    x_yearly = 0,
    immediate = TRUE
){
  
  FINAL_VALUE <- tibble(period = 1:n_per,
                        final_value  = v_0 * (1 + period * (exp_return/100)))
    
}
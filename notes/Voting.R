# Voting function based on Bayes Rule
# Length must be the same
vote <- function(report, accuracy){
 l = length(report)
 for (j in 1:l){
   if (!report[j]){
     accuracy[j] = 1-accuracy[j]
   }
 }
 trueprob = 0.5
 for (j in 1:20){
   trueprob = trueprob*prod(accuracy)/(trueprob*prod(accuracy)+(1-trueprob)*prod(1-accuracy))
 }
 if(trueprob > 0.5){
   return (TRUE)
 }
 else{
   return (FALSE)
 }
}

# Numeric
c(1,2,3,4)
c(.004, -4.2, 17, 123)
1:5
# Character
c("a", "banana", "cool!")
# Factors
factor(c("a", "banana", "cool!"))
# Date/Time
strptime("2015-06-24", "%Y-%m-%d")
# Array/Matrix
matrix(letters[1:25], ncol=4)
array(1:(2*4*6), c(2,4,6))
# Function
function(x) x+1
# Formula
bmi ~ age + gender + calories
# Environments
environment()
# Data frames
data.frame(a=1:3, b=c("f","g","h"))
#lists
x <- list(a=1:10, b=function(x) x+5, 	c=list(x="x", y=a~b))



dd<-readr::read_csv("gpa,classyear,sex
  4.0,1,1
  3.2,2,2
  3.7,3,1
  2.9,4,2
  3.5,2,2
  2.3,2,1")

lm(gpa ~ classyear + sex, dd)
lm(gpa ~ factor(classyear) + factor(sex), dd)

dd <- mutate(dd, 
  classyear = factor(classyear,
    levels=1:4,
    labels=c("Fresh", "Soph","Junior","Senior")),
  sex = factor(sex, levels=1:2,
    labels=c("Male","Female"))
)
lm(gpa~classyear+sex, dd)

sqrt(2)
c(sqrt(2), 1e6)
c(sqrt(2), 2)
print(c(sqrt(2), 2), digits=2)
print(sqrt(2), digits=12)

x <- "Hi\t1\t2\\3\nDone!\n"
x
cat(x)

a <- 0.1
a <- a + .05
b <- 0.15
a==b
all.equal(a, b)
sprintf("%a",a)
sprintf("%.20f",a)





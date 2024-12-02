#1. Create a numerical value with decimal part. Convert it to integer and then
#to character. See what are the changes (in values and printing). 

#2. Create two variables with text. Check the documentation of paste() and try
#to use it on created vectors. Compare the results of paste() function and c(). 
#What are the differences? Why?

#3. a) Convert vector vecDate <- c("09:12:12", "28:02:16", "31:05:22") to Date class. 
#b) Calculate number of days between these dates and today's date. 

vecDate<-c("09:12:12", "28:02:16", "31:05:22")
vecDate.Date<-as.Date(vecDate,format="%d:%m:%y")
class(vecDate.Date)
today<-Sys.Date()
today
differences<-vecDate.Date-today
differences

#4. Create a vector "vec1" which will include numbers from 2 to 8 and from 17 to 30. 
#Use the shortest code possible.

VEC1<-c(2:8, 17:30)
VEC1

#5. Create a vector "vec2" with given structure: (2,  8, 14, 20, 26, 32). Use seq() function. 

vec2<-c(seq(from=2,to=32,by=6))
vec2

#6. Create a vector with given structure: "2", "7", "a", "2", "7", "a", "2", "7", "a". TIP: rep()

vec3<-rep(c(2,7,"a"),times=3)
vec3

#7. Create a vector of length 100, which will store consecutive numbers divisible by three. 

vec4<-c(seq(from=3,to=300,by=3))
vec4
length(vec4)          

#8. Using only one line of code create a vector "vec3" with following structure: 
(1, 1, 3, 3, 5, 5, 7, 7, 9, 9, 1, 1, 3, 3, 5, 5, 7, 7, 9, 9, 1, 1, 3, 3, 5, 5, 7, 7, 9, 9). 

vec3<-rep(c(seq(from=1,to=9,by=2)),each=2,times=3)
vec3

#9. Generate a vector "vec4" of 50 numbers with the usage of runif() function. What does
#it do? Use generated numbers to create a vector of 50 random integer values from the 
#range 0-20. 

vec5<-as.integer(c(runif(50,min=0,max=20)))
vec5

#10. Print values from the 5th, 10th and 26th element of previously created vector.

vec5[c(5,10,26)]


#11. Print values of every second element from the previously created vector, 
#starting from the 5th element of the vector. TIP: seq(). 

vec5<-as.integer(c(runif(50,min=0,max=20)))
vec5
vec5[c(5,10,26)]
vec5[c(seq(from=5,to=50, by=2))]

1. Create a factor with values "a", "b", "c" of length 7. Add labels "Letter A",
"Letter B", "Letter C". Summarize factor values. 

myfactor<-factor(c("a","b","c","a","b","b","a"),levels=c("a","b","c"),labels=c("letter A","letter B","letter C"))
length(myfactor)
summary(myfactor)


myfactor<-factor(c("a","b","c","b","c","a","b"),
                 labels=c("LetterA","LetterB","LetterC"))
summary.factor(myfactor)


2. Create a numeric vector with values 1-4 and length 10. You can use any function
for creating the vector. Values can be ordered randomly. Summarize the variable 
and check its type. Then use this vector to create an ordered factor. Set levels
to "low" "medium" "high" "very high". Summarize the value and compare it to the initial vector. 

vec<-c(runif(10,min=0,max=4))
class(vec)
vec
orderedfac<-factor(vec,levels=c(1,2,3,4),labels=("low","medium","high","very high"))
vec


Generate random numbers
numvec <- c(runif(10, min=0, max=4))

Define breakpoints for categorization
breaks <- c(-Inf, 1, 2, 3, Inf)  # Define breakpoints for the categories

Create an ordered factor based on those breakpoints
orderedfac <- cut(numvec, 
                  breaks = breaks, 
                  labels = c("low", "medium", "high", "very high"), 
                  ordered = TRUE)

Display summary
summary(orderedfac)

3. Create a matrix with 5 rows and 2 columns, filled with zeros. Save it to "table" 
variable. 



table<-matrix(0,nrow=5,ncol=2)
table[,1]<-3
table[3,2]<-20
table[,2]
class(table[,2])
table[4,2]<-"twelve"
table[,2]
class(table[,2])
class(table[,1])
table


table<-matrix(0,nrow=5,ncol=2)
table

a) fill 1st column with values 3, 

table<-matrix(0,nrow=5,ncol=2)
table[,1]<-3
table

b) set 3rd element of 2nd column to 20. 

table<-matrix(0,nrow=5,ncol=2)
table[,1]<-3
table[3,2]<-20
table

c) Print values of the 2nd column. Check the type of the values in this column. 
d) Change the 4th element of the 2nd column to "twelve". Print values of the 
second column again. Check their type. What is different? 
e) What is the type of the values of the first column? Why?

table<-matrix(0,nrow=5,ncol=2)
table[,1]<-3
table[3,2]<-20
table
class(table[,1])

#Numeric


4. Create four variables with different types (vectors, matrices, single values).
Create a list out of these objects named "myList". 



a) Now get the second element of the list and add an additional value to it. 
Save the change so that it will be visible in the list. 
b) Add new elements at the end of the list - make it a 6-element vector of any type.  
c) Print the 4th element of the last object in the list. 

mypassion<-"My passion is Knowledge"
subjects<-c("R intro","Unsupervised","Micro","Macro","Statistics")
cars<-matrix(c("Merc","BMW","Audi","Porsche","Chevy","Dodge"),nrow=3,ncol=2)
mylist<-list(mypassion,subjects,cars)
mylist[[3]][4]


d) Change the value of the 5th element of that last object to NA.


mypassion<-"My passion is Knowledge"
subjects<-c("R intro","Unsupervised","Micro","Macro","Statistics")
cars<-matrix(c("Merc","BMW","Audi","Porsche","Chevy","Dodge"),nrow=3,ncol=2)
mylist<-list(mypassion,subjects,cars)
mylist[[3]][4]
mylist[[3]][5]<-NA
mylist



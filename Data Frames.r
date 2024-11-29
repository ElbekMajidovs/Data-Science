1. Create and add unique names to five vectors of length 8. Make their types 
diverse. Create a dataframe named "mySet1" out of created vector. 
a) Show the 5th row of created dataframe. 
b) Change the name of the second column of mySet1 dataframe to "column02"
c) Show 7 first rows of mySet1 dataframe. Use two different methods - with 
indexes and with a function. 

mySet2<-data.frame(
 Id_num=c(1:8),
 Names=c("Elbek","Adil","Qodir","Boy","Ewa","Anna","Eliza","Farida"),
 Degree=c("Bachelors","Master","Master","Doctors","High school","High school","College","College"),
 Age=c(23:30),
 Look=c("Handsome","Moderate","Medium","Medium","Ugly","Moderate","Beautiful","Medium")
)
mySet2[5,]
colnames(mySet2)[2]<-"column02"
colnames(mySet2)
head(mySet2,7)
mySet2[1:7,]

2. Use iris dataset. Using indexing show values of every 3rd row between 
40th and 120th observations. Try to use a one-liner (shorten the code so that 
it fits in one line only, without any intermediate steps).

iris[seq(from=40,to=120,by=3),]

3. Use built-in "women" dataset. 
a) Change type of the first column to character.
b) Add two new rows to the dataset with made-up numbers. Make sure that you 
don't loose the types of variables in the main dataframe in the process. 
c) Add new variable to the dataset and name it "shoe_size". Using runif function
create the values for this variable. Shoe size must be an integer between 35 and 42.

women
women<-rbind(women, c(73,168), c(74,170))
women

shoe.size=c(as.integer(runif(17,min=35,max=42)))
women<-cbind(women, shoe.size)
women

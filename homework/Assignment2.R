# Assignment 2
# Author: Callis, Suzi 
# Date: 08/29/2026

# Assignment 2
# Author: Callis, Suzi 
# Date: 08/29/2026

#Question 1: What are three ways that we can assign the value of 25 to y?
y=25
y<-25
y<<-25

#Question 2: How would I print the following line, including the quotes, in R?
#He said, “I’m Garth Marenghi. Author. Dreamweaver. Visionary. Plus actor.”
print('He said, “I’m Garth Marenghi. Author. Dreamweaver. Visionary. Plus actor.”')

#Question 3: What if I wanted to add backslashes into the statement from Question 1 to make the statement below?
#He said, “I’m Garth Marenghi. Author\Dreamweaver\Visionary. Plus actor.”
print('He said, "I’m Garth Marenghi. Author\\Dreamweaver\\Visionary. Plus actor."')
cat('He said, "I’m Garth Marenghi. Author\\Dreamweaver\\Visionary. Plus actor."')

#Question 4: Show two ways to get the following array: 1 2 3
c(1,2,3)
1:3

#Question 5: What does R call things like +, -, sin(), c(), etc? What about <-? 
#+, -, sin(), c(), and <- are all functions
#<- while it is a function, it is also an assignment, and it creates a binding

#Question 6: What’s the difference in the way R processes the while() and the for() below?
> x <- 0;
> while (x <= 3) {
+     x <- x + 1;
+ }
> x
[1] 4
#while() loop keeps running until the condition x<=3 (x≤3) is false in the temporary environment, R processes it in the following way: 
#1. The loop starts with x=0 
#2. 0+1=1 1<3 so it loops again and now x=1
#3. 1+1=2 2<3 so it loops again and now x=2
#4. 2+1=3 3=3 so it loops again and now x=3
#5. 3+1=4 4≠3 so the loop stops
#6. R prints [1] 4, and x<-4 is stored in the global environment
> for(y in c(1,2,3)) {
+     y <- y + 1;
+ }
> y
[1] 4
#for() loop keeps running until it has assigned all values in c(1,2,3) to y in the temporary environment, R processes it in the following way:
#1. The loop starts with y=1
#2. 1+1=2 so it loops again with y=2, the next value in c(1,2,3) NOT because 2 was the last assingment of y 
#3. 2+1=3 so it loops again with y=3, the next value in c(1,2,3) NOT because 3 was the last assingment of y 
#4. 3+1=4 so the loop stops since 3 is the final value in c(1,2,3)
#5. R prints [1] 4, and y<-4 is stored in the global environment
#The key difference between the while() and for() is - 
#The while() keeps updating with the last assignment of the variable and keeps looping until the condition x<=3 is false. Once the condition is false, the last value of the x variable is then stored in the global environment.
#The for() evaluates each value inside c(1,2,3) and assigns it to the variable y one at a time. It will keep looping until all values inside c(1,2,3) have been assigned. Y is updated, but the assignment of y does not persist across iterations. Once all values in c(1,2,3) have been looped, the final value of y from the last loop is then stored in the global environment 

#Question 7: Create the Pythagorean formula and evaluate it with a=3 and b=4. Print the output.
pythagorean <- function(a, b) {
  sqrt(a^2 + b^2)
}
print(pythagorean(3,4))

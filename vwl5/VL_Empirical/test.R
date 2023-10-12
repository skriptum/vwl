# Introduction
print("Hello World")

x <- 1
y <- "Text"

class(x)
class(y)

# More complex

vector <- c(1,2,3,4)
length(vector) #length of vector

m =  matrix(1:12,3,4) # (contents, rows, columns)
m[1,] # first row, all columns
m[,3]

# Data Frames
df <- data.frame(x = c(1,2,3), y = c("a","b","c"))
df$x # first column

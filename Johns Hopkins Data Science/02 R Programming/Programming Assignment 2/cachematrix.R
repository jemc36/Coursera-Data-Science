# Programming Assignment 2 Lexical Scoping
# Create a special object that stores a matrix and caches its inverse
makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    } 
    get <- function() x
    setsolve <- function(solve) m <<- solve
    getsolve <- function() m
    list(set=set, get=get, setsolve=setsolve, getsolve=getsolve)
}


# cache the inverse value
cacheSolve <- function(x, ...) {
    m <- x$getsolve()
    if(!is.null(m)){
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setsolve(m)
    m
}

# Demo
m1 <- matrix(c(1/2, -1/4, -1, 3/4), nrow = 2, ncol = 2)
m1

I2 <- matrix(c(1,0,0,1), nrow = 2, ncol = 2)
I2

n1 <- matrix(c(6,2,8,4), nrow = 2, ncol = 2)
n1

m1 %*% n1

n1 %*% m1

solve(m1)

solve(n1)

myMatrix_object <- makeCacheMatrix(m1)

# should return exactly the matrix n1
cacheSolve(myMatrix_object)

# calling cacheSolve again should retrieve (not recalculate) n1 and showing getting cached data
cacheSolve(myMatrix_object)

# you can use the set function to "put in" a new matrix.
# For example n2
n2 <- matrix(c(5/8, -1/8, -7/8, 3/8), nrow = 2, ncol = 2)
myMatrix_object$set(n2)
# and obtain its matrix inverse by
cacheSolve(myMatrix_object)
# getting cached data
cacheSolve(myMatrix_object)
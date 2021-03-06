## This pair of functions can be utilised to retrieve the inverse of a matrix
## from cache, if it exists. In case the matrix inverse does not exist the 
## matrix inverse is calculated and saved in cache for future retrieval. This
## is faster and a computationally cheaper method than calculating the inverse 
## each it is needed, especially for very large matrices. 

## Function: makeCacheMatrix(x=matrix()) 
## Input: A matrix or nothing. Default value is a NULL matrix.
## Output: returns a list of four functions on the matrix
## 1. set() - sets the value of the matrix and resets the dummy (or cache) 
##            variable to NULL
## 2. get() - retrieves the value of the matrix
## 3. setInverse() - sets the value of the dummy (or cache) variable
## 4. getInverse() - retrieves the value of the dummy (or cache) variable

makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setInverse <- function(inverse) m <<- inverse
    getInverse <- function() m
    list(set = set, get = get,
         setInverse = setInverse,
         getInverse = getInverse)
}


## Function: cacheSolve(x, ... )
## Input: List object generated by makeCacheMatrix()
## Output: returns the inverse of the input matrix for makeCacheMatrix() 
## by calculation or retrieval from cache.
## Assumption - Input matrix for makeCacheMatrix() is square and invertible

cacheSolve <- function(x, ...) {
    m <- x$getInverse()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setInverse(m)
    m
}

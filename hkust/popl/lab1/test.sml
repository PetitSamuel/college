fun checkTriangle (x,n) = if x = n*(n+1) div 2 then true else if x > n*(n+1) div 2 then checkTriangle(x, n+1) else false;

fun isTriangle(x) = checkTriangle(x,0);
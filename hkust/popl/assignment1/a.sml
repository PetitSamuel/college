type matrix = real list list;

(* Get the Ith value from a list *)
fun getIth(head::tail, i: int) = if i = 0 then head else getIth(tail, i - 1);

(* Get a specific value i,j from a matrix. *)
fun MatGet(Mat: matrix, i:int, j: int):real = getIth(getIth(Mat, i), j);

(* Get summed values of a list *)
fun sum([]) = 0.0 | sum(x::tail): real = x + sum(tail);

(* Get the summed values of a matrix *)
fun sumMat([]) = 0.0 | sumMat(h::t): real = sum(h) + sumMat(t);

(* Get the length of a list *)
fun len([]) = 0 | len(x::tail): int = 1 + len(tail);

(* Get the amount of values in a matrix *)
fun lenMat([]) = 0 | lenMat(h::t): int = len(h) + lenMat(t);

(* Get the Mean value of a matrix *)
fun MatMean(Mat: matrix):real = sumMat(Mat) / real(lenMat(Mat));


fun cropArray(values: real list, (s,e)) = List.drop(List.take(values, e), s);

fun cropW([], (_,_)) = [] | cropW(h::t, (s,e)) = cropArray(h, (s,e))::cropW(t, (s,e));

fun cropH(mat: matrix, (s,e)) =  List.drop(List.take(mat, e), s);

fun MatCrop (Mat: matrix, (H_start, H_end), (W_start, W_end)):matrix = cropH(cropW(Mat, (W_start, W_end)), (H_start, H_end));

fun mapToThreshold([], _) = [] |mapToThreshold(h::t: real list, value: real) = if(h < value) then 0.0::mapToThreshold(t, value) else 1.0::mapToThreshold(t, value);

fun iterateBinarize([], _) = [] | iterateBinarize(h::t: matrix, value: real) = mapToThreshold(h, value)::iterateBinarize(t, value);

fun MatBinary(Mat: matrix, threshold: real): matrix = iterateBinarize(Mat, threshold);

val m= [4.0,5.0,6.0];
val n= [1.0,2.0,3.0];

fun MatDot(MatA: matrix, MatB: matrix):matrix= [];

fun dotMultiplication([], _) = [] | dotMultiplication(_, []) = [] |  dotMultiplication(h1::t1: real list, h2::t2: real list) = h1 * h2::multiplyAndAdd(t1, t2);
fun sumDotProduct(list1: real list, list2: real list) = sum(dotMultiplication(list1, list2));

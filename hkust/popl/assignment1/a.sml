type matrix = real list list;

(* Test Matrix *)
val m = [[1.0,2.0,3.0],[4.0,5.0,6.0],[7.0,8.0,9.0]];

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

fun cropm([], (_,_)) = [] | cropm (h::t, (s,e)) = let val h = List.drop(List.take(h, e), s) in cropm(t, (s,e)) end;

fun MatCrop (Mat: matrix, (H_start, H_end), (W_start, W_end)):matrix = cropm(List.drop(List.take(Mat, H_end), H_start), (W_start, W_end));

val b = MatCrop(m, (1,2),(0,2));

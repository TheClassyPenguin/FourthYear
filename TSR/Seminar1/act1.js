/* act1 */ 

function table(x) { // Prints column x of a (1..10) multiplication table
for (var j=1; j<11; j++)
	console.log("%d * %d = %d", x, j, x*j);
	console.log("");
}
function allTables() {
	for (var i=1; i<11; i++)
	table(i);
}

table(5, 4, 1);

/*
A)Describe the output provided by that program. Justify whether the usage of multiple
arguments in the call made in line 12 has any effect or not. 

5*1=5
5*2=10
.
.
.
5*10=50

No, the multiple arguments in line 12 have no effect.

B)Let us assume that the original line 12 is replaced with the following one. In that case,
which is the output of the resulting program? Why?


NaN * 1 = NaN
NaN * 2 = NaN
.
.
.
NaN * 10 = NaN

C)Let us assume, again, that the original line 12 is replaced with the following one. In this
case, which is the output of the resulting program? Why?

The output is the multiplication tables of 1-10. The aditional parameters in allTables do nothing.

D) Considering your answers to the previous questions, please justify whether JavaScript
tolerates additional arguments in function calls and whether using those arguments
may have any effect.

Javascript tolerates additional arguments but won't do anything about them if there is no code planned for it.

*/
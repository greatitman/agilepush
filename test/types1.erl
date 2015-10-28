-module(type1).
-spec myand1(_,_)	->	boolean().
myand1(true,true)	-> true.
bug1(X,Y)	->
	case myand1(X,Y) of
		true ->
			X + Y
	end.

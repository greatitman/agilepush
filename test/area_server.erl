-module(area_server).
-export([loop/0]).

loop()	->
	receive
		{Fro,{rect,W,H}}	->
			io:format("Area of rect is ~p~n",[W*H]),
			Fro!W*H,
			loop();
		{square,S}	->
			io:format("Area os square is ~p~n",[S*S]),
			loop()
end.

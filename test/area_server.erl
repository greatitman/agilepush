-module(area_server).
-export([loop/0,rpc/2]).

rpc(Pid,Request)	->
	Pid ! {self(),Request},
	receive
		{Pid,	Response}	->
%			Response	->
			Response
	end.

loop()	->
	receive
		{Fro,{rect,W,H}}	->
			io:format("Area of rect is ~p~n",[W*H]),
			Fro!{self(),W*H},
			loop();
		{From,{circle,R}}	->
			From ! {self(),3.14159 *R * R},
			loop();
		{From,{square,S}}	->
			io:format("Area os square is ~p~n",[S*S]),
			loop();
		{From,Other}	->
			From !{self(),{error,Other}},
			loop()
end.

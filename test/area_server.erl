-module(area_server).
-export([start/0,area/2,loop/0]).

rpc(Pid,Request)	->
	Pid ! {self(),Request},
	receive
		{Pid,	Response}	->
%			Response	->
			Response
	end.
start()	->	spawn(area_server,loop,[]).

area(Pid,What)	->
	rpc(Pid,What).
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
			From!{self(),S*S},
			loop();
		{From,Other}	->
			From !{self(),{error,Other}},
			loop()
end.

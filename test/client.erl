-module(client).
-export([crpc/1]).

crpc(Request)	->
	Pid=spawn(area_server,loop,[]),
	area_server:rpc(Pid,Request).



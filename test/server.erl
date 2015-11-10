-module(server).
-export([start/2,rpc/2,swap_code/2]).

start(Name,Mod)	->
	register(Name,spawn(fun()	->loop(Name,Mod,Mod:init()) end)).
swap_code(Name,Mod)	->rpc(Name,{swap_code,Mod}).
rpc(Name,Request)	->
	Name ! {self(), Request},
	io:format(" name is ~p ~p~n",[Name,Request]),
	receive
		{Name, crash}	-> exit(rpc);
		{Name, ok, Response}	-> Response
	end.

loop(Name,Mod,OldState)	->
	receive
		{From, {swap_code, NewCallBackMod}}	->
			From ! {Name, ack},
			loop(Name,NewCallBackMod,OldState);
		{From, Request}	->
			{Response,NewState} = Mod:handle(Request, OldState),
			From ! {Name, ok, Response},
			loop(Name,Mod,NewState);
		_Other	->
			log_the_error(Name,Request,_Other)
	end.

log_the_error(Name,Request,Why)	->
	io:format("server ~p request ~p ~n"
			  "caused exception ~p~n",
			  [Name,Request, Why]).

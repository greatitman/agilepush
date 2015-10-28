-module(retest).
-export([display/0]).
-record(man,{name,age=0,school}).

-spec display() -> ok | {error,any()}.
display() ->
	M=#man{name="xx",age=31,school="No.1"},
	
	io:format("M is: ~p ~n",[M]).



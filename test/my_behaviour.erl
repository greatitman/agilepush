-module(my_behaviour).
-export([behaviour_info/1]).

behaviour_info(callbacks)	->
	[{init,1},{handle,2}];
behaviour_info(_Other)	->
	undefined.

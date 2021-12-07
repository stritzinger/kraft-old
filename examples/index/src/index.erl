-module(index).

-behaviour(application).

% Callbacks
-export([start/2]).
-export([stop/1]).

%--- Callbacks -----------------------------------------------------------------

start(_StartType, _StartArgs) ->
    kraft:start(#{port => 8090}, [
        {"/", kraft_static, #{file => "index.html"}},
        {"/error", module_does_not_exist, #{}}
    ]),
    {ok, self()}.

stop(_State) ->
    kraft:stop().

-module(chat).

-behaviour(application).
-behaviour(kraft_controller).

% Callbacks
-export([start/2]).
-export([stop/1]).
-export([init/2]).

%--- Callbacks -----------------------------------------------------------------

start(_StartType, _StartArgs) ->
    kraft:start(#{port => 8093}, [
        {"/chatroom", {ws, chat_room}, #{}, #{type => json}},
        {"/", ?MODULE, #{}}
    ]),
    chat_sup:start_link().

stop(_State) ->
    kraft:stop().

init(Conn, _Params) ->
    {200, #{}, kraft:render(Conn, "index.html", #{})}.

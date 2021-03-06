%%%
%% Copyright 2013 Andreas Stenius
%%
%%  Licensed under the Apache License, Version 2.0 (the "License");
%%  you may not use this file except in compliance with the License.
%%  You may obtain a copy of the License at
%%
%%    http://www.apache.org/licenses/LICENSE-2.0
%%
%%  Unless required by applicable law or agreed to in writing, software
%%  distributed under the License is distributed on an "AS IS" BASIS,
%%  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%  See the License for the specific language governing permissions and
%%  limitations under the License.
%%
-module(yabot_client).

-include("yabot.hrl").

-type name() :: atom().
-type name_node() :: {name(),node()}.
-type global_name() :: {global, GlobalName::term()}.
-type via_name() :: {via, Module::atom(), ViaName::term()}.
-type server_ref() :: name() | name_node() | global_name() | via_name() | pid().

-callback add_bridge(ServerRef :: server_ref(), Peer :: term()) -> ok.
-callback handle_message(ServerRef :: server_ref(), Message :: #yabot_msg{}) -> Reply :: term().
-callback handle_message(ServerRef :: server_ref(), Message :: #yabot_msg{}, 
                         Options :: [{atom(), term()}]) -> Reply :: term().
     

%% API
-export([
         add_bridge/2,
         handle_message/2
        ]).


%%%===================================================================
%%% API functions
%%%===================================================================

add_bridge(Src, Dst) ->
    yabot_sup:client_req(Src, add_bridge, [Dst]).

handle_message(Id, #yabot_msg{}=Message) ->
    yabot_sup:client_req(Id, handle_message, [Message]).

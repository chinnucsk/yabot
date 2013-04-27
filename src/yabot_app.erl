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
-module(yabot_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% Api
-export([start/0, stop/0]).


%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    yabot_sup:start_link().

stop(_State) ->
    [application:stop(App) || App <- [exmpp, eircc]],
    ok.

%% ===================================================================

start() ->
    application:start(yabot).

stop() ->
    application:stop(yabot).

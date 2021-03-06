%%%=============================================================================
%%% @copyright (C) 1999-2018, Erlang Solutions Ltd
%%% @author Denys Gonchar <denys.gonchar@erlang-solutions.com>
%%% @doc this module provides general TLS interface for MongooseIM.
%%%
%%% by default tls_module is set to fast_tls, alternatively it can be any
%%% module that implements ejabberd_tls behaviour
%%% @end
%%%=============================================================================
-module(ejabberd_tls).
-copyright("2018, Erlang Solutions Ltd.").
-author('denys.gonchar@erlang-solutions.com').

%% tls interfaces required by ejabberd_socket & ejabberd_receiver modules.
-export([tcp_to_tls/2,
         send/2,
         recv_data/2,
         controlling_process/2,
         sockname/1,
         peername/1,
         setopts/2,
         get_peer_certificate/1,
         close/1]).

-export([get_sockmod/1]).

-type tls_socket() :: any().
-type cert() :: {ok, Cert::any()} | {bad_cert, bitstring()} | no_peer_cert.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% behaviour definition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-callback tcp_to_tls(inet:socket(), Opts::list()) -> {ok, tls_socket()} | {error, any()}.

-callback send(tls_socket(), binary()) -> ok | {error , any()}.

-callback recv_data(tls_socket(), binary()) -> {ok, binary()} | {error, any()}.

-callback controlling_process(tls_socket(), pid()) -> ok | {error, any()}.

-callback sockname(tls_socket()) -> {ok, {inet:ip_address(), inet:port_number()}} |
                                    {error, any()}.

-callback peername(tls_socket()) -> {ok, {inet:ip_address(), inet:port_number()}} |
                                    {error, any()}.

-callback setopts(tls_socket(), Opts::list()) -> ok | {error, any()}.

-callback get_peer_certificate(tls_socket()) -> cert().

-callback close(tls_socket()) -> ok.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% socket type definition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-record(ejabberd_tls_socket, {tls_module :: module(),
                              tcp_socket :: inet:socket(),
                              tls_socket :: tls_socket(),
                              tls_opts :: list(),
                              has_cert :: boolean()
}).

-type socket() :: #ejabberd_tls_socket{}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% APIs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-spec tcp_to_tls(inet:socket(), Opts::list()) -> {ok, socket()} | {error, any()}.
tcp_to_tls(TCPSocket, Opts) ->
    Module = proplists:get_value(tls_module, Opts, fast_tls),
    NewOpts = proplists:delete(tls_module, Opts),
    case Module:tcp_to_tls(TCPSocket, NewOpts) of
        {ok, TLSSocket} ->
            HasCert = has_peer_cert(NewOpts),
            {ok, #ejabberd_tls_socket{tls_module = Module,
                                      tcp_socket = TCPSocket,
                                      tls_socket = TLSSocket,
                                      tls_opts   = NewOpts,
                                      has_cert   = HasCert}};
        Error -> Error
    end.


-spec send(socket(), binary()) -> ok | {error, any()}.
send(#ejabberd_tls_socket{tls_module = M, tls_socket = S}, B) -> M:send(S, B).


-spec recv_data(socket(), binary()) -> {ok, binary()} | {error, any()}.
recv_data(#ejabberd_tls_socket{tls_module = M, tls_socket = S}, B) -> M:recv_data(S, B).


-spec controlling_process(socket(), pid()) -> ok | {error, any()}.
controlling_process(#ejabberd_tls_socket{tls_module = M, tls_socket = S}, Pid) ->
    M:controlling_process(S, Pid).


-spec sockname(tls_socket()) -> {ok, {inet:ip_address(), inet:port_number()}} | {error, any()}.
sockname(#ejabberd_tls_socket{tls_module = M, tls_socket = S}) -> M:sockname(S).


-spec peername(tls_socket()) -> {ok, {inet:ip_address(), inet:port_number()}} | {error, any()}.
peername(#ejabberd_tls_socket{tls_module = M, tls_socket = S}) -> M:peername(S).


-spec setopts(socket(), Opts::list()) -> ok | {error, any()}.
setopts(#ejabberd_tls_socket{tls_module = M, tls_socket = S}, Opts) -> M:setopts(S, Opts).


-spec get_peer_certificate(socket()) -> cert().
get_peer_certificate(#ejabberd_tls_socket{has_cert = false}) ->
    no_peer_cert;
get_peer_certificate(#ejabberd_tls_socket{tls_module = M, tls_socket = S}) ->
    get_peer_cert(M, S).


-spec close(socket()) -> ok.
close(#ejabberd_tls_socket{tls_module = M, tls_socket = S}) -> M:close(S).


-spec get_sockmod(socket()) -> module().
get_sockmod(#ejabberd_tls_socket{tls_module = Module}) -> Module.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% local functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
has_peer_cert(Opts) ->
    %% server always provides cert, client - only per request
    case {lists:member(connect, Opts), lists:member(verify_none, Opts)} of
        {false, true} -> %% we are tls server, and we haven't requested client's certificate
            false;
        _ ->
            true
    end.

get_peer_cert(fast_tls, Socket) ->
    case {fast_tls:get_verify_result(Socket), fast_tls:get_peer_certificate(Socket)} of
        {0, {ok, Cert}} -> {ok, Cert};
        {Error, {ok, Cert}} -> {bad_cert, fast_tls:get_cert_verify_string(Error, Cert)};
        {_, error} -> no_peer_cert
    end;
get_peer_cert(M, S) ->
    M:get_peer_certificate(S).
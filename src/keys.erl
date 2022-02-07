-module(keys).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(_Args) ->
    _Key = ecc_compact:generate_key(),
    SwarmKey = filename:join(["/mnt/1TB/helium_ansible/miner_keys/161.35.4.5", "miner", "swarm_key"]),
    ok = filelib:ensure_dir(SwarmKey),
    case libp2p_crypto:load_keys(SwarmKey) of
        {ok, #{secret := _PrivKey0, public := PubKey}} ->
            FallbackOnboardingKey = libp2p_crypto:pubkey_to_b58(PubKey),
            io:format("~p~n", [FallbackOnboardingKey]);
        {error, enoent} ->
            io:format("error")
    end,
    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================

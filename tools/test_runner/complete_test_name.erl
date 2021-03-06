-module(complete_test_name).
-export([main/1]).

main([Suite]) ->
    suggest_for_suite(Suite),
    erlang:halt().


suggest_for_suite(Suite) ->
    Module = to_module(Suite),
    All = all(Module),
    Groups = groups(Module),
    Expanded = expand_all(All, Groups),
    lists:foreach(fun(What) -> io:format("~p:~ts~n", [Suite, What]) end, Expanded).

all(Module) ->
    try Module:all() of
        All ->
            All
    catch
        Class:Reason ->
            Stacktrace = erlang:get_stacktrace(),
            io:format(standard_error,
                      "all_call_failed suite=~p reason=~p:~p~n "
                      "stacktrace=~p~n",
                      [Module, Class, Reason, Stacktrace]),
            []
    end.

groups(Module) ->
    case erlang:function_exported(Module, groups, 0) of
        true ->
            call_groups(Module);
        false ->
            %% Do not fail, if there is no groups callback
            []
    end.

call_groups(Module) ->
    try Module:groups() of
        Groups ->
            Groups
    catch
        Class:Reason ->
            Stacktrace = erlang:get_stacktrace(),
            io:format(standard_error,
                      "groups_call_failed suite=~p reason=~p:~p~n "
                      "stacktrace=~p~n",
                      [Module, Class, Reason, Stacktrace]),
            []
    end.

expand_all(All, Groups) ->
    lists:flatmap(fun(A) -> expand_all_element(A, Groups) end, All).

expand_all_element({group, GroupName}, Groups) when is_atom(GroupName) ->
    [atom_to_list(GroupName)|expand_group(GroupName, Groups)];
expand_all_element(TestCase, _Groups) when is_atom(TestCase) ->
    [atom_to_list(TestCase)];
expand_all_element(Other, _Groups) ->
    io:format(standard_error,
              "expand_all_element:unknown_element other=~p",
              [Other]),
    [].

to_module(Suite) when is_atom(Suite) ->
    list_to_atom(atom_to_list(Suite) ++ "_SUITE").

expand_group(GroupName, Groups) ->
    case lists:keyfind(GroupName, 1, Groups) of
        false ->
            io:format(standard_error,
                      "expand_group:group_not_found group=~p",
                      [GroupName]),
            [];
        GroupSpec ->
            expand_group_spec(GroupSpec)
    end.


expand_group_spec({GroupName, _Opts, Tests}) when is_atom(GroupName) ->
    expand_group_path(atom_to_list(GroupName), Tests);
expand_group_spec(GroupSpec) ->
    io:format(standard_error,
              "expand_group_spec:unknown_group_spec_format group_spec=~p",
              [GroupSpec]),
    [].


expand_group_path(Path, Tests) ->
    lists:flatmap(fun(Test) -> expand_group_test(Path, Test) end, Tests).

expand_group_test(Path, Test) when is_atom(Test) ->
    [Path ++ ":" ++ atom_to_list(Test)];
expand_group_test(Path, {GroupName, _Opts, Tests}) when is_atom(GroupName) ->
    Path2 = Path ++ ":" ++ atom_to_list(GroupName),
    expand_group_path(Path2, Tests);
expand_group_test(_Path, GroupSpec) ->
    io:format(standard_error,
              "expand_group_spec:unknown_group_spec_format group_spec=~p",
              [GroupSpec]),
    [].

defmodule Shunt do

    @doc """
        a procedure find that takes two trains xs and ys as input and returns 
        a list of moves, such that the moves transform the state {xs, [], []}
        into {ys, [], []}
    """

    def find([], []) do [] end
    def find(xs, [head|ys]) do
        {hs, ts} = Train.split(xs, head)
        tn = length(hs)
        hn = length(ts)
        [
            {:one, hn + 1}, {:two, tn}, 
            {:one, -(hn + 1)}, {:two, -(tn)}
            | find(Train.append(ts, hs), ys)
        ]
    end

    @doc """
        a function few that behaves as find but takes each recursive application into 
        whether the next wagon is already in the right position. If so, no moves needed
    """

    def few([], []) do [] end
    def few([head|xs], [head|ys]) do few(xs, ys) end
    def few(xs, [head|ys]) do 
        {hs, ts} = Train.split(xs, head)
            tn = length(hs)
            hn = length(ts)
            [
                {:one, hn + 1}, {:two, tn}, 
                {:one, -(hn + 1)}, {:two, -(tn)}
                | few(Train.append(ts, hs), ys)
            ]   
    end  

    def rules([]) do [] end
    def rules([{head, n}, {head, m}|tail]) do 
        rules([{head, n + m}|tail])
    end
    def rules([{_, 0}|tail]) do rules(tail) end
    def rules([head|tail]) do [head|rules(tail)] end

    def compress(ms) do
        ns = rules(ms)
        if ns == ms do
            ms
        else
            compress(ns)
        end
    end

end
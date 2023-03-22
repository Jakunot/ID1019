defmodule Cards do

    def lt({:card, s, v1}, {:card, s, v2}) do v1 < v2 end
    #club is lowest card
    def lt({:card, :club, _}, {:card, _, _}) do true end
    #diamond is lower that heart and spade
    def lt({:card, :diamond, _}, {:card, :heart, _}) do true end
    def lt({:card, :diamond, _}, {:card, :spade, _}) do true end
    #heart is lower that spade only
    def lt({:card, :heart, _}, {:card, :spade, _}) do true end

    def lt({:card, _, _}, {:card, _, _}) do false end


    def sort([]) do [] end
    def sort([n]) do [n] end
    def sort(deck) do
        {a, b} = split(deck)
        merge(sort(a), sort(b))
    end

    def split(deck) do split(deck, [], []) end
    def split([], s1, s2) do {s1, s2} end
    def split([c|t], s1, s2) do 
        split(t, [c|s2], s1) 
    end

    def merge([], s2) do s2 end
    def merge(s1, []) do s1 end
    def merge([c1|r1]=s1, [c2|r2]=s2 ) do
        if lt(c1, c2) do
            [c1 | merge(r1, r2)]
        else
            [c2 | merge(s1, s2)]
        end
    end

    def test() do
        deck = [
            {:card, :heart, 5},
            {:card, :heart, 7},
            {:card, :spade, 2},
            {:card, :club, 9},
            {:card, :diamond, 4}]
        sort(deck)
    end
end
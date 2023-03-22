defmodule Train do

    @doc """
        returns the train containing the first n wagons of train
    """
    def take(_, 0) do [] end
    def take([head|tail], n) when n > 0 do
        [head|take(tail,n-1)]
    end

    @doc """
        returns the train wihtout its first n wagon
    """
    def drop(train, 0) do train end
    def drop([_|tail], n) when n > 0 do
        drop(tail, n-1)
    end
    
    @doc """
        appends two trains and returns the combination of both
        for example, append([:a,:b], [:c]) returns [:a, :b, :c]
    """
    def append([], train2) do train2 end
    def append([head|tail], train2) do [head|append(tail,train2)] end

    @doc """
        tests whether y is a wagon of train
    """
    def member([], _) do false end
    def member([y|_], y) do true end
    def member([_, tail], y) do member(tail, y) end

    @doc """
        returns the first position (1 indexed) of y in the train, you can assume y i¨
        s a wagon in train.
        for example, position ([:a, :b, :c], :b) returns 2
    """
    def position([y|_], y) do 1 end
    def position([_|tail], y) do position(tail, y) + 1 end
    
    @doc """
        return a tuple with two trains, all the wagons before y and all wagons after y
        for example:
                split([:a, :b, :c], :a) = {[], [:b, :c]}
                split([:a, :b, :c], :c) = {[:a], [:c]}
    """
    def split([y|tail], y) do {[], tail} end
    def split([head|tail], y) do
        {tail, drop} = split(tail, y)
        {[head|tail], drop}
    end
    @doc """
        returns the tuple {k, remain, take} where remain and take are the wagons of train 
        and k are the numbers of wagons
        for example:
                main([:a, :b, :c, :d], 3) = {0, [:a], [:b, :c, :d]}
                main([:a, :b, :c, :d], 5) = {1, [], [:a], [:b, :c, :d]}
    """
    def main([], n) do {n, [], []} end
    def main([head|tail], n) do 
        case main(tail, n) do
            {0, drop, take} ->
                {0, [head|drop], take}

            {n, drop, take} ->
                {n-1, drop, [head|take]}
        end
    end

end
defmodule Atoms do

    """ 
    Atoms are constants whose values are their own name. They are often useful to enumerate 
    over distinct values

    """
    def price(item) do
        case item do
            :cucumber -> 10
            :tomato -> 23
            :orange -> 32
            :potatoes -> 5
        end
    end

    def roman(r) do
        case r do
            :i -> 1
            :v -> 5
            :x -> 10
            :l -> 50
            :c -> 100
            :d -> 500
            :m -> 1000
        end
    end

    """
    Tuples are intended as fixed-size containers for multiple elements. A tuple 
    may contain elements of different types, which are store contiguosly in memory.
    Accessing any element takes constant time, but modifying a tuple, which produces a shallow copy, 
    takes linear time. Tuples are good for reading data while lists are better for traversals.

    """
    #simple tuple function 
    def calc(rom) do
        case rom do
            {a, b, c, d} ->
                roman(a) +
                roman(b) +
                roman(c) +
                roman(d) 
            _ ->
                :error
        end
    end

end
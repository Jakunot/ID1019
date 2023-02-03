defmodule Recursion do
    
    #pattern matching
    """
    - [h|t] = [:a, :b, :c] is interpreted h = :a and t = [:b, :c] as in
        the rest of the list

    - [h1, h2, t] = [:a, :b, :c] is interpreted h1 = :a, h2 = :b and t =
        [:c] as in the rest of the list

    - [h1, h2, t] = [:a, :b, :c] is interpreted h1 = :a, h2, :b and t =
        :c
    - [h1, h2, t] = [:a, :b, :c, :d] error because of different sizes

    - [h1, [h2|t]] = [:a, :b, :c] is interpreted h1 = :a, h2 = :b and t =
        [:c] as in the rest of the list

    - [h|t] = [:a|:b] is interpreted h = :a and t = :b

    """
    #eventually may run out of memory, consumes stack space
    def union([], y) do y end
    def union([h|t], y) do
        z = union(t, y)
        [h|z]
    end

    #tail recursion, basically doesn't need to remember (put in stack)
    def tailr([], y) do y end
    def tailr([h|t], y) do 
        tailr(t, [h|y])
    end

    #calculate odd 
    def odd([]) do [] end
    def odd([h|t]) do
        if rem(h,2) == 1 do 
            [h | odd(t)]
        else
            odd(t)
        end
    end

    #calculate even 
    def even([]) do [] end
    def even([h|t]) do
        if rem(h,2) == 0 do 
            [h | even(t)]
        else
            even(t)
        end
    end

    #calculate odd n even numbers and separate them inside a tuple using 2 lists
    #running through the list while checking if value is odd or even
    def odd_n_even([]) do {[], []} end
    def odd_n_even([h|t]) do
        {o, e} = odd_n_even(t)
        if rem(h, 2) == 1 do
            {[h|o], e}
        else
            {o, [h|e]}
        end
    end

    #if indifferent to order, this is the efficient way to write it
    def udd_n_even(lst) do udd_n_even(lst, [], [])end
    def udd_n_even([], odd, even) do {odd, even} end
    def udd_n_even([h|t], odd, even) do 
        if rem(h,2) == 1 do
            udd_n_even(t, [h|odd], even)
        else
            udd_n_even(t, odd, [h|even])
        end
    end

    #looks easier on the eye but runs down the list in 2 functions
    #think if the list given was bigger
    def add_n_even(lst) do
        o = odd(lst)
        e = even(lst)
        {o,e}
    end

end
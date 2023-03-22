defmodule Hanoi do 
    
    @doc """
        where a = source, b = auxiliary and c = target
        By moving the "disks" recursively, the function builds eventually 
        reaches a point where the base case is zero
    """
    
    def hanoi(0,_,_,_) do [] end 
    def hanoi(n, a, b, c) do
        hanoi(n-1, a, c, b) ++ [{:move, a, c}] 
        ++ hanoi(n-1, b, a, c)
    end

end
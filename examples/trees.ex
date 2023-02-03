defmodule Trees do

    #Return the n'th element from a list
    def nth(1, [r|_]) do r end
    def nth(n, [_|t]) do nth(n-1, t) end

    
    #add property to a list
    def add(elm, []) do [elm] end
    def add(elm, [h|t]) do
        [h | add(elm, t)]
    end

    #remove property to a list
    def remove([]) do :error end
    def remove([elm|rest]) do {:ok, elm, rest} end


    def append(element, {:queue, first, last}) do 
        {:queue, first, [element | last]} 
    end

    def withdraw({:queue, [], []}) do :error end
    def withdraw({:queue, [], last}) do 
        withdraw({:queue, reverse(last), []})
    end
    def withdraw({:queue, [element| rest], last}) do 
        {:ok, element, {:queue, rest, last}}
    end


    def member(_, :nil) do :no end
    def member(elm, {:leaf, elm}) do :yes end
    def member(_, {:leaf, _}) do :no end
    def member(elm, {:node, elm, _, _}) do :yes end
    def member(elm, {:node, _, left, right}) do 
        case member(elm, left) do
            :yes -> :yes
            :no -> member(elm, right)
        end
    end

end
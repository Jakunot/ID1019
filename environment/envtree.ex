defmodule Envtree do
    
    #creating a new empty tree structure, return nil if there is nothin
    def new()do nil end

    @doc """
        Unlike EnvList, we are not "updating" the tree that we have, but rather 
        constructing a copy of the tree where we have added the new key-value
        pair
    """

    @doc """
        Implementing lookup/2 is very similar to the add/3 function. The difference
        is of course that we are not building a new tree, but returning the found key-
        value pair or nil if not found
    """
    #add a new pair 
    def add(nil, key, value) do {:node, key, value, nil, nil} end
    #if the key that is specified is found, replace it
    def add({:node, key, _, left, right}, key, value) do
        {:node, key, value, left, right}
    end
    #return a tree that looks like the one we have but where the left branch has been updated
    def add({:node, k, v, left, right}, key, value) when key < k do
        {:node, k, v, add(left, key, value), right}
    end
    #if the current key is larger thatn the current node's key, the right branch gets updated
    def add({:node, k, v, left, right}, key, value) do
        {:node, k, v, left, add(right, key, value)}
    end

    #look up value in an empty tree
    def lookup(nil, _)do nil end
    #if the key we are looking is found, return the {key, value} pair
    def lookup({:node, key, value, _, _}, key) do {key, value} end
    #traversing the left branch if k > key
    def lookup({:node, k, _, left, _}, key)when key < k do lookup(left, key) end
    #traversing the right branch if k < key
    def lookup({:node, _, _, _, right}, key) do lookup(right, key) end

    @doc """
        Implementing remove/2, slightly more tricky and you have to remember the algorithm 
        how to do this. The idea is to first locate the key to remove and then replace it with 
        the leftmost key-value pair in the right branch
    """
    #base case, remove key-value pair from an empty tree.
    def remove(nil, _) do nil end
    def remove({:node, key, _, nil, right}, key) do right end
    def remove({:node, key, _, left, nil}, key) do left end
    #if the key is found, but is stuck in the middle of other branches, replace it with the leftmost pair
    def remove({:node, key, _, left, right}, key) do 
        {key, value, rest} = leftmost(right)
        {:node, key, value, left, rest}
    end
    #traversing the left branch if k > key
    def remove({:node, k, v, left, right}, key) when key < k do 
        {:node, k, v, remove(left, key), right}
    end
    #traversing the right branch if k < key
    def remove({:node, k, v, left, right}, key) do
        {:node, k, v, left, remove(right, key)}
    end
    
    def leftmost({:node, key, value, nil, rest})do {key, value, rest} end
    def leftmost({:node, k, v, left, right}) do 
        {key, value, rest} = leftmost(left)
        {key, value, {:node, k, v, rest, right}}
    end



end
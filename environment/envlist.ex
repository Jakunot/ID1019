defmodule Envlist do 
    #base case, when a map is empty, returns an empty list
    def new() do [] end

    @doc """
        a function add that returns a map where an association of the key(key) and the
        data structure value(value) has been added to the given map. If there already
        is an associtation of the key the value is changed.
    """
    #add a key-value pair into an empty list
    def add([], key, value) do [{key, value}] end
    #if the key that is specified is found, update the value associated with specified key
    def add([{key, _}| map], key, value) do [{key, value} | map] end
    #updates the list at the tail, head referring to the first pair in the list 
    def add([head|map], key, value) do [head| add(map, key, value)] end

    @doc """
        a function lookup that returns either{key, value}, if the key(key) is associated 
        with the data structure value, or nil if no association is found.
    """
    #look up value for key in an empty list, but disregard it
    def lookup([], _key) do nil end
    #look up a specific key ignoring the value associated with the key
    def lookup([{key, _value}=pair|tail], key) do pair end
    def lookup([_|tail], key)do lookup(tail, key) end

    @doc """
        a function remove that returns a map where the association of the key(key) has been 
        removed
    """
    #base case
    def remove([], _key) do [] end
    #after find key specified, return tail with key remove
    def remove([{key, _value}|tail], key)do tail end
    def remove([head|tail], key) do [head|remove(tail, key)] end


end
defmodule Moves do

    @doc """
        binary function single/2 that takes a move and an input state then
        returns a new state computed from the state with the move applied
        (remember a move is  a binary tuple)
        for example:
                single(:one, 1), {[:a, :b], [], []} returns {[:a], [:b], []}

        -   the move is {:one, 0} has no effect, should return the same state
        -   if the move is {:one, n} and n > 0, then the n right-most wagons are moved from 
            track "main" to track "one". if there are more than n wagons on track "main", the 
            other wagons remain
        -   if the move is {:one, n} and n < 0, then the n left-most wagons are moved from 
            track "one" to track "main". if there are more than n wagons on track "one", 
            the  other wagons remain
    """

    def single({_, 0}, state) do state end
    
    # n > 0, right-most wagons are moved from track "main" to track "one"
    def single({:one, n}, {main, one, two}) when n > 0 do
        {0, remain, wagons} = Train.main(main, n)
        {remain, Train.append(wagons, one), two}
    end

    # n < 0, left-most wagons are moved from track "one" to track "main"
    def single({:one, n}, {main, one, two}) when n < 0 do
        wagons = Train.take(one, -n)
        {Train.append(main, wagons), Train.drop(one, -n), two}
    end

    # n > 0, right-most wagons are moved from track "main" to track "two"
    def single({:two, n}, {main, one, two}) when n > 0 do
        {0, remain, wagons} = Train.main(main, n)
        {remain, one, Train.append(wagons, two)}
    end

    # n < 0, left-most wagons are moved from track "two" to track "main"
    def single({:two, n}, {main, one, two}) when n < 0 do
        wagons = Train.take(two, -n)
        {Train.append(main, wagons), one, Train.drop(two, -n)}
    end
    
    @doc """
        a function sequence/2 that takes a list of moves and a state and returns a list
        of states that represents the transitions when the moves are performed.
    """
    def sequence([], state) do [state] end
    def sequence([head|tail], state) do 
        [state| sequence(tail, single(head, state))]
    end


end
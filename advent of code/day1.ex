defmodule Day1 do

    #This |> operator introduces the expression on the left-hand 
    #side as the first argument to the function call on the right-hand side.

    def challenge1() do
        File.stream!("input.txt") #without ! returns an atom that can be used for pattern matching
        |> Stream.map(&String.trim/1)
        |> Stream.chunk_by(fn(x) -> x != "" end) #chunks the enurable for which the function returns the same value
        |> Stream.reject(fn(x) -> x == [""] end) # Creates a stream that will reject elements according to the given function
        |> Enum.map(&( Enum.reduce(&1, 0, fn s, acc -> acc + String.to_integer(s) end)))
        |> Enum.max()
    end

    def challenge2() do
        File.stream!("input.txt")
        |> Stream.map(&String.trim/1)
        |> Stream.chunk_by(fn(x) -> x != "" end) 
        |> Stream.reject(fn(x) -> x == [""] end) 
        |> Enum.map(&( Enum.reduce(&1, 0, fn s, acc -> acc + String.to_integer(s) end)))
        |> Enum.sort(:desc) |> Enum.take(3) |> Enum.sum()
    end


end
defmodule Test do

    #simple function to add x with 5
    def add5(x) do
        x + 5
    end

    #simple function to add x with y
    def addxy(x, y) do
        x + y
    end

    #simple function to convert celsius to fahrenheit
    def to_fahren(c) do
        c * 1.8 + 32
    end

    #simple function to convert fahrenheit to celsius
    def to_celsius(f) do
        (f - 32)/1.8
    end
    
    #simple recursion
    def fib(n) do
        if n == 0 do
        0
        else
            if n == 1 do
                1
            else
                fib(n - 1) + fib(n - 2)
            end
        end
    end

    #another way to write the fibonacci sequence in elixir
    def fibonacci(s) do
        case s do 
            0 -> 0
            1 -> 1
            _ ->        #the underscore representing any value
                fibonacci(s - 1) + fibonacci(s - 2)
        end
    end
end
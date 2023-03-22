defmodule Conc do
    
    """ 
    -   Concurrency: (the illusion of) happening at the same time, which is a property of 
        the programming model 

    -   Shared memory: modify a shared data structure
        ->   C++/C
        ->   Java
    -  Message passing: processes send and receive messages
        ->   Erlang/Elixir
        ->   Go
        ->   Scala
        ->   Occam
        ->   Rust   

    -   Communicating Sequential Processes (CSP), messages are sent through channels, a process
        can choose to read a message from one or more channels
        ->  Go, Occam, Rust
    -   Actor mdoel, messages are sent to a process, a process reads implicitly from its own channel
        ->  Erlang/Elixir, Scala

    -   An actor:
        ->  State: keeps a provate state that can only be changed by the actor
        ->  Receive: has one channel of incoming messages
        ->  Execute: given a state and a received message, the actor can;
            -   send: send a number of messages to other actors
            -   spawn: create a number of new actors
            -   transform: modify its state and continue, or terminate
    

    """


end
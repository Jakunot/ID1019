defmodule Morse do
    #encoding
    def encode(text) do
        encode(text,encode_table(),[])
    end
    def encode([],_, coded) do Enum.reverse(coded) end
    def encode([char|text],table, sofar) do
        encode(text,table, encode_lookup(char, table) ++[32] ++ sofar)
    end

    def codes(:nil, _) do [] end
    def codes({:node,:na, long,short},code) do
        codes(long,[?-|code]) ++ codes(short,[?.|code])
    end
    def codes({:node,char,long,short},code) do
        [{char,code}]++ codes(long,[?-|code]) ++ codes(short,[?.|code])
    end

    def encode_lookup(char,[{char, code} | _]) do code  end
    def encode_lookup(char,[_ | rest]) do encode_lookup(char,rest) end
    def encode_lookup(char, map) do Map.get(map, char) end

    def encode_table() do
        codes = codes(morse(),[])
        Enum.reduce(codes, %{},fn({char,code },acc) -> Map.put(acc,char,code)end)
    end
    


    #decoding 
    def decode(signal) do
        table = decode_table()
        decode(signal, table, [])
    end
    def decode([], _, acc) do Enum.reverse(acc) end
    def decode(signal, table , acc) do
        {char, rest} = decode_char(signal,table)
        decode(rest, table,[char|acc])
    end

    def decode_table() do
        morse()
    end

    def decode_char(signal) do
        table = decode_table()
        decode_char(signal,table)
    end
    def decode_char([],{:node, char, _, _}) do {char,[]} end

    def decode_char([?-|signal], {:node, _, long, _}) do
        decode_char(signal, long)
    end
    def decode_char([?.| signal], {:node, _,_, short}) do
        decode_char(signal,short)
    end
    def decode_char([?\s|signal], {:node,:na , _, _ }) do
    {?*,signal}
    end
    def decode_char([?\s|signal], {:node,char , _, _ }) do
        {char,signal}
    end

    #secret morse code to decode
    def base() do '.- .-.. .-.. ..-- -.-- --- ..- .-. ..-- -... .- ... . ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- ..-- ..- ...' end


    def rolled() do  
    '.... - - .--. ... ---... .----- .----- .-- .-- .-- .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-. --- -- .----- .-- .- - -.-. .... ..--.. ...- .----. -.. .--.-- ..... .---- .-- ....- .-- ----. .--.-- ..... --... --. .--.-- ..... ---.. -.-. .--.-- ..... .---- 'end

    def solution() do
        IO.puts(decode(base()))
        decode(rolled())
    end

    
    
# The decoding tree.  
    def morse() do
        {:node, :na,
            {:node, 116,
                {:node, 109,
                    {:node, 111,
                        {:node, :na, {:node, 48, nil, nil}, {:node, 57, nil, nil}},
                        {:node, :na, nil, {:node, 56, nil, {:node, 58, nil, nil}}}},
                    {:node, 103,
                        {:node, 113, nil, nil},
                        {:node, 122,
                            {:node, :na, {:node, 44, nil, nil}, nil},
                            {:node, 55, nil, nil}}}},
                {:node, 110,
                    {:node, 107, {:node, 121, nil, nil}, {:node, 99, nil, nil}},
                    {:node, 100,
                        {:node, 120, nil, nil},
                        {:node, 98, nil, {:node, 54, {:node, 45, nil, nil}, nil}}}}},
            {:node, 101,
                {:node, 97,
                    {:node, 119,
                        {:node, 106,
                            {:node, 49, {:node, 47, nil, nil}, {:node, 61, nil, nil}},
                        nil},
                        {:node, 112,
                            {:node, :na, {:node, 37, nil, nil}, {:node, 64, nil, nil}},
                        nil}},
                    {:node, 114,
                        {:node, :na, nil, {:node, :na, {:node, 46, nil, nil}, nil}},
                        {:node, 108, nil, nil}}},
                {:node, 105,
                    {:node, 117,
                        {:node, 32,
                            {:node, 50, nil, nil},
                            {:node, :na, nil, {:node, 63, nil, nil}}},
                        {:node, 102, nil, nil}},
                    {:node, 115,
                        {:node, 118, {:node, 51, nil, nil}, nil},
                        {:node, 104, {:node, 52, nil, nil}, {:node, 53, nil, nil}}}}}}
    end

# The codes in an ordered list.
    def codes() do
        [
            {32,"..--"},
            {37,".--.--"},
            {44,"--..--"},
            {45,"-....-"},
            {46,".-.-.-"},
            {47,".-----"},
            {48,"-----"},
            {49,".----"},
            {50,"..---"},
            {51,"...--"},
            {52,"....-"},
            {53,"....."},
            {54,"-...."},
            {55,"--..."},
            {56,"---.."},
            {57,"----."},
            {58,"---..."},
            {61,".----."},
            {63,"..--.."},
            {64,".--.-."},
            {97,".-"},
            {98,"-..."},
            {99,"-.-."},
            {100,"-.."},
            {101,"."},
            {102,"..-."},
            {103,"--."},
            {104,"...."},
            {105,".."},
            {106,".---"},
            {107,"-.-"},
            {108,".-.."},
            {109,"--"},
            {110,"-."},
            {111,"---"},
            {112,".--."},
            {113,"--.-"},
            {114,".-."},
            {115,"..."},
            {116,"-"},
            {117,"..-"},
            {118,"...-"},
            {119,".--"},
            {120,"-..-"},
            {121,"-.--"},
            {122,"--.."}
        ]
    end

end

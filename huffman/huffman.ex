defmodule Huffman do
    
    def sample do
        'the quick brown fox jumps over the lazy dog
        this is a sample text that we will use when we build
        up a table we will only handle lower case letters and
        no punctuation symbols the frequency will of course not
        represent english but it is probably not that far off'
    end

    def text() do
        'this is something that we should encode'
    end
    
    def test do
        sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        decode = decode_table(tree)
        text = text()
        seq = encode(text, encode)
        decode(seq, decode)
    end
    
    def tree(sample) do 
        freq = freq(sample)
        huffman(freq)
    end

    def freq(sample)do freq(sample, []) end
    def freq([], freq) do freq end
    def freq([char|rest], freq) do
        freq(rest, update(char, freq))
    end
    
    def update(char, []) do [{char,1}] end
    def update(char, [head|tail]) do
        case head do 
            {^char, nr} -> [{char, (nr+1)}|tail]
            {_, _} -> [head|update(char, tail)]
        end
    end

    def huffman(freq) do
        sorted = Enum.sort(freq, fn({_, x}, {_, y}) -> x < y end)
        huffman_tree(sorted)
    end

    def huffman_tree([{tree, _}]) do tree end
    def huffman_tree([{a, af}, {b, bf} | rest]) do
        huffman_tree(insert({{a, b}, af + bf}, rest))
    end

    def insert({a, af}, []), do: [{a, af}]
    def insert({a, af}, [{b, bf} | rest]) when af < bf do
        [{a, af}, {b, bf} | rest]
    end
    def insert({a, af}, [{b, bf} | rest]) do
        [{b, bf} | insert({a, af}, rest)]
    end


    #create an encoding table containing the mapping from characters to codes_better given
    # a Huffamn tree
    def encode_table(tree) do
        Enum.sort(codes(tree, []), fn({_,x},{_,y}) -> length(x) < length(y) end)
    end
    
    #create an decoding table containing the mapping from codes_better to characters given 
    # a Huffman tree
    def decode_table(tree) do codes(tree, []) end
    def codes({a, b}, sofar) do 
        as = codes(a, [0|sofar])
        bs = codes(b, [1|sofar])
        as ++ bs
    end
    def codes(a, code) do
        [{a, Enum.reverse(code)}]
    end


    #encode the text using the mapping in the table, return sequence of bits
    def encode([], _) do [] end
    def encode([char|rest], table) do
        code = lookup(char, table)
        code ++ encode(rest, table)
    end

    def lookup(_, []) do :error end
    def lookup(char, [let|rest]) do 
        case let do 
            {^char, code} -> code
            _-> lookup(char, rest)
        end
    end

    #decode the bit sequence using the mapping in the table, return a text
    def decode([], _) do [] end
    def decode(seq, table) do   
        {char, rest} = decode_char(seq, 1, table)
        [char|decode(rest, table)]
    end

    def decode_char(seq, n, table) do
        {code, rest} = Enum.split(seq, n)
        case List.keyfind(table, code, 1) do
            {let, _} -> {let, rest}
            nil -> decode_char(seq, n+1, table)
        end
    end


    def read(file) do
        {:ok, file} = File.open(file, [:read, :utf8])
        binary = IO.read(file, :all)
        File.close(file)

        case :unicode.characters_to_list(binary, :utf8) do
            {:incomplete, list, _} -> list
            list -> list
        end
    end

end
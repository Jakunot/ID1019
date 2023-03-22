defmodule Derive do

    @type literal() ::  {:num, number()}  
    | {:var, atom()}

    @type expr() :: {:exp, literal(), {:num, number()}}
    | {:add,  expr(), expr()}
    | {:mul,  expr(), expr()}
    | {:div,  expr(), expr()}
    | {:exp,  expr(), expr()}
    | {:sqrt, expr()}
    | {:ln,   expr()}
    | {:cos,  expr()}
    | {:sin,  expr()}
    | literal()

    @doc """
        derivation rules 
        Implementing the derivatives of function: 
        constant, linear, power, exponential, sine, cosine
    """
    def deriv({:num, _}, _) do {:num, 0} end
    def deriv({:var, v}, v) do {:num, 1} end
    def deriv({:var, _}, _) do {:num, 0} end
    def deriv({:add, e1, e2}, v) do {:add,  deriv(e1, v), deriv(e2, v)} end
    def deriv({:mul, e1, e2}, v) do
        {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}}
    end
    def deriv({:div, e1, e2}, v) do
        {:div, 
            {:add, 
                {:mul, deriv(e1, v), e2}, 
                {:mul, 
                    {:mul, e1, deriv(e2, v)}, 
                    {:num, -1}
                }
            },
            {:exp, e2, {:num, 2}}
        }
    end
    def deriv({:exp, e, {:num, exp}}, v) do 
        {:mul, {:mul, {:num, exp}, {:exp, e, {:num, exp-1}}}, deriv(e, v)}
    end
    def deriv({:sqrt, e}, v) do
        {:div, deriv(e, v), {:mul, {:num, 2}, {:sqrt, e}}}
    end
    def deriv({:sin, e}, v) do {:mul, deriv(e, v), {:cos, e}} end
    def deriv({:cos, e}, v) do {:mul, {:mul, {:num, -1}, deriv(e, v)}, {:sin, e}} end

    
    @doc """
        simplification of expressions by removing 0s and 1s 
    """
    def simplify({:num, n}) do {:num, n} end
    def simplify({:var, v}) do {:var, v} end
    def simplify({:add, e1, e2}) do 
        simplify_add(simplify(e1), simplify(e2))
    end
    def simplify({:mul, e1, e2}) do 
        simplify_mul(simplify(e1), simplify(e2))
    end
    def simplify({:div, e1, e2}) do 
        simplify_div(simplify(e1), simplify(e2))
    end
    def simplify({:exp, e1, e2}) do 
        simplify_exp(simplify(e1), simplify(e2))
    end
    def simplify({:sqrt, e}) do 
        simplify_sqrt(simplify(e))
    end
    def simplify({:sin, e}) do 
        simplify_sin(simplify(e))
    end
    def simplify({:cost, e}) do 
        simplify_cos(simplify(e))
    end

    #addtion
    def simplify_add({:num, 0}, e) do e end
    def simplify_add(e1, {:num, 0}) do e1 end
    def simplify_add({:num, 0}, e2) do e2 end
    def simplify_add({:num, n1}, {:num, n2}) do {:num, n1 + n2} end
    def simplify_add({:var, v}, {:var, v}) do {:mul, {:num, 2}, {:var, v}} end
    def simplify_add({e1, e2}) do {:add, e1, e2} end

    #multiplication
    def simplify_mul({:num, 0}, _) do {:num, 0} end
    def simplify_mul(_, {:num, 0}) do {:num, 0} end
    def simplify_mul(e1, {:num, 1}) do e1 end
    def simplify_mul({:num, 1}, e2) do e2 end
    def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1 * n2} end
    def simplify_mul(e1, e2) do {:mul, e1, e2} end

    #division
    def simplify_div(e, {:num, 1}) do e end
    def simplify_div({:num, n1}, {:num, n2}) do {:num, n1/n2} end
    def simplify_div(e1, e2) do {:div, e1, e2} end

    #exponent
    def simplify_exp(e, {:num, 1}) do e end
    def simplify_exp(_, {:num, 0}) do {:num, 1} end
    def simplify_exp(e1, e2) do {:exp, e1, e2} end
    def simplify_exp({:num, n}, {:num, exp}) do {:num, :math.pow(n, exp)} end

    #square root
    def simplify_sqrt({:num, 0}) do {:num, 0} end
    def simplify_sqrt(e) do {:sqrt, e} end
    
    #sine
    def simplify_sin(e) do {:sin, e} end

    #cosine
    def simplify_cos(e) do {:cos, e} end
    
    @doc """
        pretty print, function to make it easier to read
    """
    def pprint({:num, n}) do "#{n}" end
    def pprint({:var, v}) do "#{v}" end
    def pprint({:add, e1, e2}) do "#( #{pprint(e1)} + #{pprint(e2)} )" end
    def pprint({:mul, e1, e2}) do "( #{pprint(e1)} * #{pprint(e2)} )" end
    def pprint({:div, e1, e2}) do "( #{pprint(e1)} / #{pprint(e2)} )" end
    def pprint({:exp, e1, e2}) do "( #{pprint(e1)} ^ #{pprint(e2)} )" end
    def pprint({:sqrt, e}) do "sqrt( #{pprint(e)} )" end
    def pprint({:sin, e}) do "sin( #{pprint(e)} )" end
    def pprint({:sqrt, e}) do "cos( #{pprint(e)} )" end

    
    #test
    def test() do
        e = {:add, {:exp, {:var, :x}, {:num, 2}}, {:num, 5}}
        d = deriv(e, :x)
        IO.write("Expression: #{pprint(e)}\n")
        IO.write("Derivative: #{pprint(d)}\n")
        IO.write("Simplified: #{pprint(simplify(d))}\n")
        :ok
    end

    
end
defmodule Expression do

    @type literal() :: 
          {:num, number()}
        | {:var, atom()}
        | {:q, number(), number()}
    @type expr() :: 
          {:add, expr(), expr()}
        | {:sub, expr(), expr()}
        | {:mul, expr(), expr()}
        | {:div, expr(), expr()}
        | literal()

    @doc """
        eval/2, takes an expression and an environment and evaluates the expression to a literal.
        The enviroment is mapping from variable names to values. The eval/2 passes the expressions
        to the corresponding arithmetic functions.  
    """
  def eval({:num, num}, _env) do num end
  def eval({:var, v}, env) do Map.get(env, v) end
  def eval({:add, e1, e2}, env) do
    eval1 = eval(e1, env)
    eval2 = eval(e2, env)
    if eval1 == :undefined || eval2 == :undefined do
      :undefined
    else
      addition(eval1, eval2)
    end
  end
  def eval({:sub, e1, e2}, env) do
    eval1 = eval(e1, env)
    eval2 = eval(e2, env)
    if eval1 == :undefined || eval2 == :undefined do
      :undefined
    else
      subraction(eval1, eval2)
    end
  end
  def eval({:mul, e1, e2}, env) do
    eval1 = eval(e1, env)
    eval2 = eval(e2, env)
    if eval1 == :undefined || eval2 == :undefined do
      :undefined
    else
      multiplication(eval1, eval2)
    end
  end
  def eval({:div, e1, e2}, env) do
    numerator = eval(e1, env)
    denominator = eval(e2, env)
    if numerator == :undefined || denominator == 0  do
      :undefined
    else
        divide(numerator, denominator)
    end
  end
  def eval({:q, e1, e2}, _env) do
    if e2 == 0 do :undefined
    else
      gcd = Integer.gcd(e1, e2)
      {:q, e1/gcd, e2/gcd}
    end
  end

    @doc """
        The arithmetic functions, following some simple mathematics rules
    """

  #addition
  defp addition({:q, numerator1, denominator1}, {:q, numerator2, denominator2}) do 
    {:q, numerator1 * denominator2 + numerator2 * denominator1, denominator1 * denominator2} 
  end
  defp addition(num, {:q, numerator, denominator}) do {:q, num * denominator + numerator, denominator} end
  defp addition({:q, numerator, denominator}, num) do {:q, num * denominator + numerator, denominator} end
  defp addition(num1, num2) do num1 + num2 end

  #subraction
  defp subraction({:q, numerator1, denominator1}, {:q, numerator2, denominator2}) do 
    {:q, (numerator1 * denominator2) - (numerator2 * denominator1), (denominator1 * denominator2)} 
  end
  defp subraction(num, {:q, numerator, denominator}) do {:q, (num * denominator) - numerator, denominator} end 
  defp subraction({:q, numerator, denominator}, num) do {:q, numerator - (num * denominator), denominator} end
  defp subraction(num1, num2) do num1 - num2 end

  # multiplication
  defp multiplication({:q, numerator1, denominator1}, {:q, numerator2, denominator2}) do
    {:q, (numerator1 * numerator2), (denominator1 * denominator2)}
  end
  defp multiplication(num, {:q, numerator, denominator}) do {:q, (num * numerator), denominator} end
  defp multiplication({:q, numerator, denominator}, num) do {:q, (num * numerator), denominator} end
  defp multiplication(num1, num2) do  num1 * num2 end

  #division
  defp divide({:q, numerator1, denominator1}, {:q, numerator2, denominator2}) do 
    {:q, (numerator1 * denominator2), (numerator2 * denominator1)} 
  end
  defp divide(num, {:q, numerator, denominator}) do {:q, (num * denominator), numerator} end
  defp divide({:q, numerator, denominator}, num) do {:q, numerator, (denominator * num)} end
  defp divide(num1, num2) do {:q, num1, num2} end
  
  
  #pretty print, taken from derivative
  def pprint(expression) do
    case expression do
      {:num, n} -> "#{n}"
      {:var, v} -> "#{v}"
      {:q, numerator, denominator} -> "#{numerator}/#{denominator}"
      {:add, e1, e2} -> "#{pprint(e1)} + #{pprint(e2)}"
      {:sub, e1, e2} -> "#{pprint(e1)} - #{pprint(e2)}"
      {:mul, e1, e2} -> "#{pprint(e1)} * #{pprint(e2)}"
      {:div, e1, e2} -> "(#{pprint(e1)}) / (#{pprint(e2)})"
      _ -> "Error: invalid expression"
    end
  end
  
  #test
  def test1()  do
    env = %{x: 2}
    # 2x + 3 + 1/2
    expression = {:add, {:add, {:mul, {:num, 2}, {:var, :x}}, {:num, 3}}, {:q, 1, 2}}

    IO.write("Expression: #{pprint(expression)}\n")
    IO.write("Result with pprint function: #{pprint(eval(expression, env))}\n")
    IO.write("Result: ")
    eval(expression, env)
  end

  def test2()  do
    env = %{a: 1, b: 2, c: 3, d: 4}
    expression = {:div, {:add, {:mul, {:num, 2}, {:var, :a}}, {:var, :c}},{:add, {:num, 4}, {:q, 6, 8}}}
    IO.write("Expression: #{pprint(expression)}\n")
    IO.write("Result with pprint function: : #{pprint(eval(expression, env))}\n")
    IO.write("Result: ")
    eval(expression, env)
  end

end

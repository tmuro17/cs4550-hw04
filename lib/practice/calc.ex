defmodule Practice.Calc do

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split
    |> to_postfix
    |> postfix_evaluator
  end


  # postfix converter adapted from
  #   http://csis.pace.edu/~wolf/CS122/infix-postfix.htm
  defp to_postfix(elems, stack \\ [], acc \\ [])
  defp to_postfix([], [], acc), do: acc
  defp to_postfix([], [x | xs], acc), do:
    to_postfix([], xs, acc ++ [x])

  defp to_postfix([e | es], stack, acc) do
    if is_operator?(e) do
      if Enum.empty?(stack) do
        to_postfix(es, [e | stack], acc)
      else
        [op | ops] = stack
        if higher_precedent?(op, e) do
          to_postfix(es, [e | ops], acc ++ [op])
        else
          to_postfix(es, [e | stack], acc)
        end
      end
    else
      fl = parse_float(e)
      to_postfix(es, stack, acc ++ [fl])
    end
  end

  defp higher_precedent?(x, y) do
    low_order = ["+", "-"]

    if Enum.member?(low_order, x) do
      Enum.member?(low_order, y)
    else
      true
    end
  end

  defp is_operator?(text) do
    Enum.member?(["*", "/", "+", "-"], text)
  end

  defp parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  defp postfix_evaluator(elems, stack \\ [])
  defp postfix_evaluator([], [ans]), do: ans

  defp postfix_evaluator([e | es], stack) do
    if is_operator?(e) do
      [y | [x | rst]] = stack
      case e do
        "+" -> postfix_evaluator(es, [(x + y) | rst])
        "-" -> postfix_evaluator(es, [(x - y) | rst])
        "*" -> postfix_evaluator(es, [(x * y) | rst])
        "/" -> postfix_evaluator(es, [(x / y) | rst])
      end
    else
      postfix_evaluator(es, [e | stack])
    end
  end
end


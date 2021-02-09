defmodule Practice.Factor do
  def factor(x) do
    if x == 1 do
      [1]
    else
      Enum.sort factor_helper(x, 2, [])
    end
  end

  defp factor_helper(num, divisor, acc) do
    if divisor > num do
      acc
    else
      if is_prime(divisor) do
        cond do
          rem(num, divisor) == 0 ->
            factor_helper(div(num, divisor), divisor, [divisor | acc])
          divisor == 2 -> factor_helper(num, divisor + 1, acc)
          true -> factor_helper(num, divisor + 2, acc)
        end
      else
        factor_helper(num, divisor + 2, acc)
      end
    end
  end

  defp is_prime(num, divisor \\ 2) do
    # sqrt taken from
    # https://stackoverflow.com/questions/51035499/how-do-i-take-the-square-root-of-a-number-in-elixir
    cond do
      divisor > :math.sqrt(num) -> true
      rem(num, divisor) == 0 -> false
      divisor == 2 -> is_prime(num, divisor + 1)
      true -> is_prime(num, divisor + 2)
    end
  end
end

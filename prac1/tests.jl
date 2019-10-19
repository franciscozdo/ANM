using Printf

# Implementacje reprezentacji (struktury trzymające odpowiednie współczynniki)
struct Lagrange-naive
  n::Int # stopień wielomianu
  x::Array{Float64, 1} # (x_0, x_1, ..., x_n)
  y::Array{Float64, 1} # (y_0, y_1, ..., y_n)

  function Lagrange(xvalues, yvalues) # tworzenie postaci Lagrange'a z list [x0, x1, ...], [f(x0), f(x1) ...]
(x, f(x))
    lx = length(xvalues)
    ly = length(yvalues)
    if lx != ly
      error("Number of x values desn't match number of y values!")
    end
    new(lx, xvalues, yvalues)
  end
end

struct Lagrange-better
  n::Int # stopień wielomianu
  x::Array{Float64, 1} # (x_0, x_1, ..., x_n)
  y::Array{Float64, 1} # (y_0, y_1, ..., y_n)

  function Lagrange(xvalues, yvalues) # tworzenie postaci Lagrange'a z list [x0, x1, ...], [f(x0), f(x1) ...]
(x, f(x))
    error("Not implemented")
  end
end

struct Lagrange-barycentric
  n::Int # stopień wielomianu
  x::Array{Float64, 1} # (x_0, x_1, ..., x_n)
  y::Array{Float64, 1} # (y_0, y_1, ..., y_n)

  function Lagrange(xvalues, yvalues) # tworzenie postaci Lagrange'a z list [x0, x1, ...], [f(x0), f(x1) ...]
(x, f(x))
    error("Not implemented")
  end
end

struct Newton
  n::Int # stopień wielomianu
  x::Array{Float64, 1} # (x_0, x_1, ..., x_n)
  a::Array{Float64, 1} # współczynniki (a_0, a_1, ..., a_n)

  function Newton(xvalues, yvalues) # tworzenie postaci Newtona z list [x0, x1, ...], [f(x0), f(x1) ...]
    error("Not implemented")
end

# Konwersja z postaci Lagrange'a do postaci Newtona
# (tylko jeszcze nie wiem z której XD)
function L->N(lagrange)
  error("Not implemented")
end

# obliczanie dokładnej wartości funkcji w punkcie
# wynik jest BigFloatem!
function eval(f, x)
  f(BigFloat(x))
end

# obliczanie wartości wielomianu wg różnych form
function eval_lagrange_n(P, x)
  error("Not implemented")
end

function eval_lagrange_b(P, x)
  error("Not implemented")
end

function eval_lagrange_bc(P, x)
  error("Not implemented")
end

function eval_newton(P, x)
  T = typeof(x)
  result = T(0)
  X = T(1)
  n = length(P.x)
  for i in 1:n
    result += P.a[i] * X
    X *= x - P.x[i]
  end
  return result
end

function eval_poly(P, x, precise?=false)
  if precise?
    x = BigFloat(x)
  end

  if typeof(P) == Lagrange-naive
    eval_lagrange_n(P, x)
  elseif typeof(P) == Lagrange-better
    eval_lagrange_b(P, x)
  elseif typeof(P) == Lagrange-barycentric
    eval_lagrange_bc(P,x)
  elseif typeof(P) == Newton
    eval_newton(P, x)
  end
#println(Lagrange([1, 2, 3], [1, 2, 3]))

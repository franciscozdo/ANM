# Farnciszek Zdobylak nr ind. 310313
#
# Plik zawierający deklarację reprezentacji wielomianów w postaci Lagrange'a i
# Newtona, funkcje konstruujące te postaci oraz funkcje wyliczające wartość w 
# punkcie

# postać Lagrange'a wg definicji
struct LagrangeD{T}
  typ::DataType
  n::Int # stopień wielomianu + 1
  x::Array{T, 1} # (x_0, x_1, ..., x_n)
  y::Array{T, 1} # (y_0, y_1, ..., y_n)
end

function cons_LD(xvals, yvals, typ)
  n = length(xvals)
  LagrangeD(typ, n, typ.(xvals), typ.(yvals))
end

function eval_LD(P, x)
  T = P.typ
  V = T(0)
  x = T(x)
  for i in 1:P.n
    p = P.y[i]
    for j in 1:P.n
      if j != i
        p *= (x - P.x[j]) / (P.x[i] - P.x[j])
      end
    end
    V += p
  end
  return V
end

# obliczanie współczynników w_i wielomianu postaci Lagrange'a
# (algorytm wernera)
function eval_w(n, x, T)
  a = zeros(T, n, n)
  a[1, 1] = 1
  for i=2:n
    for k=1:i-1
      a[k, i] = a[k, i-1] / (x[k] - x[i])
      a[i, k+1] = a[i, k] - a[k, i]
    end
  end
  w = [a[k, n] for k in 1:n]
end

struct Lagrange{T}
  typ::DataType
  n::Int # stopień wielomianu + 1
  x::Array{T, 1} # (x_0, x_1, ..., x_n)
  y::Array{T, 1} # (y_0, y_1, ..., y_n)
  w::Array{T, 1} # (w_0, w-1, ..., w_n)
end

# tworzenie postaci Lagrange'a z list [x0, x1, ...], [f(x0), f(x1) ...]
function cons_L(xvalues, yvalues, typ) 
  n = length(xvalues)
  w = eval_w(n, typ.(xvalues), typ) 
  Lagrange(typ, n, typ.(xvalues), typ.(yvalues), w)
end

function eval_L(P, x)
  T = P.typ
  V = T(0)
  x = T(x)
  for i in 1:P.n
    p = T(P.w[i]) * P.y[i]
    for j in 1:P.n
      if j != i
        p *= x - P.x[j]
      end
    end
    V += p
  end
  return V
end

# postać Lagrange'a barycentryczna
struct LagrangeBC{T}
  typ::DataType
  n::Int # stopień wielomianu + 1
  x::Array{T, 1} # (x_0, x_1, ..., x_n)
  y::Array{T, 1} # (y_0, y_1, ..., y_n)
  w::Array{T, 1} # (w_0, w-1, ..., w_n)
end

# tworzenie postaci barycentrycznej Lagrange'a z list [x0, x1, ...], [f(x0), f(x1) ...]
function cons_LBC(xvalues, yvalues, typ) 
  n = length(xvalues)
  w = eval_w(n, typ.(xvalues), typ)
  LagrangeBC(typ, n, typ.(xvalues), typ.(yvalues), w)
end

function eval_LBC(P, x)
  for i in 1:P.n
    if x == P.x[i]
      return P.y[i]
    end
  end
  
  T = P.typ
  num = T(0)
  den = T(0)
  x = T(x)
  for i in 1:P.n
    tmp = P.w[i] / (x - P.x[i])
    den += tmp
    num += tmp * P.y[i]
  end
  return num / den
end

# obliczanie współczynników a_i wielomianu postaci Newtona
# (algorytm z wykładu)
function eval_a(n, x, y, T)
  b = [T(i) for i in y]
  for j in 2:n
    for k in n:-1:j
      b[k] = (b[k] - b[k-1]) / (x[k] - x[k-j+1])
    end
  end
  return b
end

struct Newton{T}
  typ::DataType
  n::Int # stopień wielomianu + 1
  x::Array{T, 1} # (x_0, x_1, ..., x_n)
  a::Array{T, 1} # współczynniki (a_0, a_1, ..., a_n)
end

# tworzenie postaci Newtona z list [x0, x1, ...], [f(x0), f(x1) ...]
function cons_N(xvalues, yvalues, typ) 
  n = length(xvalues)
  a = eval_a(n, typ.(xvalues), typ.(yvalues), typ)
  Newton(typ, n, typ.(xvalues), a)
end

function eval_N(P, x)
  T = P.typ
  result = T(0)
  prod = T(1)
  x = T(x)
  n = length(P.x)
  for i in 1:n
    result += P.a[i] * prod
    prod *= x - P.x[i]
  end
  return result
end

# funkcja przekształcająca postać Lagrange'a do postaci Newtona
function LtoN(L)
  T = L.typ
  x = L.x
  n = L.n
  sig = zeros(T, n, n+1)
  for i in 1:n
    sig[i, 1] = L.w[i] * L.y[i]
  end

  for k in 1:n
    for i in 1:n-k+1
      sig[n-k+1, k+1] += sig[i, k]
    end
    
    for i in n-k:-1:1
      sig[i, k+1] = (x[i] - x[n-k+1]) * sig[i, k]
    end
  end

  a = zeros(T, n)
  for i in 1:n
    a[i] = sig[i, n+1-i+1]
  end
  Newton(T, n, x, a)
end

# funkcja do wyliczania wartości wielomianu w punkcie x
function ev(P, x)
    if typeof(P) <: LagrangeD
        return eval_LD(P, x)
    end
    if typeof(P) <: Lagrange
        return eval_L(P, x)
    end
    if typeof(P) <: LagrangeBC
        return eval_LBC(P, x)
    end
    if typeof(P) <: Newton
        return eval_N(P, x)
    end
end

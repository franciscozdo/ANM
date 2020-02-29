# Franciszek Zdobylak (nr ind. 310313)


# global variables determining mode of approximation
WFUNC = x -> 1  # weight function
INTERV = (-1, 1) # closed
NPROBES = 128
PROBES = [-1 + n * Float64(2 / (NPROBES+1)) for n in 1:NPROBES] # for calculating discrete scalar product
# end of global variables

# change scalar product (interval and probes)
function ch_scalar_product(;int=(-1, 1), 
                            n = 128, 
                            prob = [-1 + n * Float64(2 / (NPROBES+1)) for n in 1:NPROBES], 
                            p = x->1)
  global INTERV = int
  global NPROBES = n
  global PROBES = prob
  global WFUNC = p
#  println("changed scalar product", 
#          "\ninterval: ", INTERV, 
#          "\nprobes: ", NPROBES, " ", PROBES)
end

struct OptPoly
  n # degree of polynomial
  A # coeficients of polynomial
  C # coeficients from recurence relation
  D
end

# return values in points from PROBES
function get_vals(f)
  return tuple([f(x) for x in PROBES]...)
end

# Argumets:
#      n - index of last polynomial (P_0, ..., P_n)
# Returns: 
#      P - values of ortogonal polynomials in x_i 
#     SP - values of scalar product <P_k, P_k>
#   C, D - coeficients of recurence relation
function get_ortogonals(n)
  P = [] 
  SP = []
  C = []
  D = []
  push!(C, 0)
  push!(D, 0)
  push!(D, 0)

  # initialize P0 and P1
  push!(P, get_vals(x -> 1))
  push!(SP, scalar_product(P[1], P[1]))
  c1 = scalar_product(get_vals(x -> x), P[1]) / SP[1]
  push!(P, get_vals(x -> x - c1))
  push!(SP, scalar_product(P[2], P[2]))
  push!(C, c1)

  for k in 3:n+1
    x = PROBES
    ck = scalar_product([x[i] * P[k - 1][i] for i in 1:NPROBES], P[k - 1]) / SP[k - 1]
    dk = SP[k - 1] / SP[k - 2]

    Pk = [ (x[i] - ck) * P[k - 1][i] - dk * P[k - 2][i] for i in 1:NPROBES]
    push!(P, Pk)
    push!(SP, scalar_product(Pk, Pk))
    push!(C, ck)
    push!(D, dk)
  end

  return P, SP, C, D
end

# arguments must be arrays of values
function scalar_product(f1, f2)
  result = Float64(0)
  for i in 1:NPROBES
    result += f1[i] * f2[i] * WFUNC(PROBES[i])
  end
  return result
end

# Arguments:
#      x - arg 
#      n - deg of polynomials
#   C, D - cooficients from recurence relation
# Returns:
#      P - values of ort. polynomials in x
function eval_ortogonals(x, n, C, D)
  P = []
  push!(P, 1)
  push!(P, x - C[2])

  for k in 3:n+1
    push!(P, (x - C[k]) * P[k - 1] - D[k] * P[k - 2])
  end
  return P
end

function get_opt(fp, n)
  P, SP, C, D = get_ortogonals(n)
  #fp = get_vals(f)
  # cooficients of optimal polynomial
  A = [scalar_product(fp, P[k]) / SP[k] for k in 1:n+1] 
  return OptPoly(n, A, C, D)
end

function eval_opt(x, W)
  result = Float64(0)
  P = eval_ortogonals(x, W.n, W.C, W.D)
  for k in 1:W.n+1
    result += W.A[k] * P[k]
  end
  return result
end



#ch_scalar_product(int=(-1, 1), n=40, p=x->1/(1 - x*x))
#n = 10
#P, SP, C, D = get_ortogonals(n)
#vals = eval_ortogonals(0, n, C, D)
#
#for i in 1:n+1
#  for j in i:n+1
#    println("scalar(", i, ", ", j, ") = ", scalar_product(P[i], P[j]))
#  end
#end
#
#A, C, D = get_opt(x -> 1, 4)
#
#println("C = ", C)
#println("D = ", D)
#println("A = ", A)
#println(vals)


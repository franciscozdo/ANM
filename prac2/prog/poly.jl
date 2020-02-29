# Franciszek Zdobylak (nr ind. 310313)

# Returns function counting value of polynomial
function rand_poly(deg)
  a = []
  for i in 0:deg
    push!(a, rand() * 2 -1) # random number from [-1, 1]
  end
  
  # Horner
  function eval_poly(x, P, n)
    result = Float64(0)
    for i in n+1:-1:1
      result = result * x + a[i]
    end
    return result
  end

  return x -> eval_poly(x, a, deg)
end

# Returns:
#     x - values where polynomial was counted
#     exact - values in x
#     dist - distortted values in x by value from [-0.1, 0.1]
function get_vals_of_poly(P, x; dist=0.1)
  #x = sort([rand() * 2 - 1 for i in 1:100])
  exact = [P(y) for y in x]
  dist = [y + rand() * 2 * dist - dist for y in exact]
  return exact, dist
end

# function to rand polynomial with zeros from [-1, 1]
function rand_extra_poly(deg)
  a = [] # list of zeros of polynomial
  b = [] # coeficients of quadratic factors
  #c = rand() # coeficient of larger power of x
  k = 0
  # we want to have at least half zeros in [-1, 1]
  while k < div(deg, 2)
    k = abs(rand(Int)) % deg
    k += (deg-k) % 2
  end
  for i in 1:k
    push!(a, rand() * 2 - 1)
  end
  for i in 1:2:deg-k
    push!(b, (rand() * 10, rand() * 10, rand() * 10)) # rand from [0, 10]
  end
  #@assert length(a)+2*length(b)==deg
  println("k: ", k)
  println("a: ", length(a), a, "\nb: ", length(b), b)
  function eval_poly(x)
    result = 1
    for i in 1:k
      result *= x - a[i]
    end
    for i in 1:length(b)
      result *= b[i][1] * x*x + b[i][2] * x - b[i][3] * x
    end
    return result
  end
  return x->eval_poly(x)
end

# parameters as in previous function
function get_with_zeros(a, b)
  function eval_poly(x)
    result = 1
    for i in 1:length(a)
      result *= x - a[i]
    end
    for i in 1:length(b)
      result *= b[i][1] * x*x + b[i][2] * x - b[i][3] * x
    end
    return result
  end
  return x->eval_poly(x)
end

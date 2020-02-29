# Franciszek Zdobylak (nr ind. 310313)

include("poly.jl")
include("orto.jl")
using Printf

# if we want data to put tu table in latex
format_to_latex=false

function get_random_probes()
  return sort([rand() * 2 - 1 for i in 1:100])
end

function get_equal_probes()
  return sort([-1 + i* 2/99 for i in 0:99])
end

# return average error on given range
# test in 10 000 points from range
function check_opt(W, P, range)
  sum = 0.0
  for i in 0:10000
    x = range[1] + i * (range[2] - range[1]) / 10000
    sum += abs(P(x) - W(x))
  end
  return sum / 10000
end

random = get_random_probes()
ch_scalar_product(int=(-1,1), n=100, prob=random)

println("\nZaburzenie rzędu 10^-1\n")
for n in 1:10 # stopień wielomianu
  println("Wielomian st", n)
  P = rand_poly(n)
  p_exact, p_distorted = get_vals_of_poly(P, random)
  for i in 1:n*2
    We = get_opt(p_exact, i)
    Wd = get_opt(p_distorted, i)
    erre = check_opt(P, x->eval_opt(x, We), (-1, 1))
    errd = check_opt(P, x->eval_opt(x, Wd), (-1, 1))
    if format_to_latex
      @printf("%d & %.4e & %.4e & %.4e\\\\\n", i, erre, errd, abs(erre-errd))
    else
      println("Optymalny st ", i)
      println("   error-E: ", erre)
      println("   error-D: ", errd)
      println("difference: ", abs(erre - errd))
    end
  end
end

println("\nZaburzenie rzędu 10^-2\n")
for n in 1:10 # stopień wielomianu
  println("Wielomian st", n)
  P = rand_poly(n)
  p_exact, p_distorted = get_vals_of_poly(P, random, dist=0.01)
  for i in 1:n*2
    We = get_opt(p_exact, i)
    Wd = get_opt(p_distorted, i)
    erre = check_opt(P, x->eval_opt(x, We), (-1, 1))
    errd = check_opt(P, x->eval_opt(x, Wd), (-1, 1))
    if format_to_latex
      @printf("%d & %.4e & %.4e & %.4e\\\\\n", i, erre, errd, abs(erre-errd))
    else
      println("Optymalny st ", i)
      println("   error-E: ", erre)
      println("   error-D: ", errd)
      println("difference: ", abs(erre - errd))
    end
  end
end

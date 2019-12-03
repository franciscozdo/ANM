# Franciszek Zdobylak nr ind. 310313
#
# Plik zawierający funkcje przydatne podczas preprowadzania testów.

using Printf

# struktura przechowująca wszystkie reprezentacje
struct TestCase
  P::LagrangeD # do obliczania wartości wielomianu z definicji w bardzo dużej precyzji
  L::Lagrange
  LB::LagrangeBC
  N::Newton
end

# generuje węzły Czebyszewa w ilości n w przedziale [-a, a]
function genChebyshevNodes(n, a, typ)
  x = zeros(typ, n)
  for i in 1:n
    x[i] = cos((2 * typ(i) - 1) * pi / (2 * typ(n)))
  end
  return [i * a for i in x]
end

function genEqual(n, a, typ)
  x = zeros(typ, n)
  for i in 1:n
    x[i] = (i - 1) * (2 * a / (n - 1)) - a
  end
  return x
end

# przybliża podaną funkcję w węzłach zadanych wartościami dla x
# zwraca krotkę zawierającą wszystkie reprezentacje
function inter(f, xvals, typ, krotka=true)

  xvals = typ.(xvals)
  LD = cons_LD(xvals, f.(xvals), BigFloat) 
  L = cons_L(xvals, f.(xvals), typ)
  LB = cons_LBC(xvals, f.(xvals), typ)
  N = cons_N(xvals, f.(xvals), typ)

  if krotka
    return (LD, L, LB, N)
  end
  return TestCase(LD, L, LB, N)
end


# zwraca błędy między wielomianem policzonym dokładnie, a resztą reprezentacji
function compare(t, x, typ, prev_prec)
  setprecision(1024)
  val = typ(eval_LD(t.P, x))
  setprecision(prev_prec)
  l = eval_L(t.L, x)
  lb = eval_LBC(t.LB, x)
  n = eval_N(t.N, x)

  dl = val - l
  db = val - lb
  dn = val - n

  return (dl, db, dn)
end

# porównuje przybliżenia z wartością funkcji
function comparef(t, x, typ)
  val = t.f(typ(x))
  l = eval_L(t.L, x)
  lb = eval_LBC(t.LB, x)
  n = eval_N(t.N, x)

  dl = val - l
  db = val - lb
  dn = val - n

  return (dl, db, dn)
end

function test(func, xvals, testvals, typ, prev_prec)
  t = inter(func, xvals, typ)
  for x in testvals
    r = compare(t, x, typ, prev_prec)
    @printf("\nPorównanie w x = %.8lf\n", x)
    @printf(" błąd L: %.20e\n", r[1])
    @printf("błąd LB: %.20e\n", r[2])
    @printf(" błąd N: %.20e\n", r[3])
  end
end

function test_case(n, generator, interval, f, typ, cmp)
  x = generator(n, interval, typ)
  case = inter(f, x, typ, false)
  ans = cmp(case, f)
  @printf("\n   %d\t&  %.4e\t&  %.4e\t&  %.4e", n, ans[1], ans[2], ans[3])
end

function cons_Newtons(n, generator, f, typ)
  x = generator(n, 1, typ)
  N1 = cons_N(x, f.(x), typ)
  N2 = LtoN(cons_L(x, f.(x), typ))
  return (N1, N2)
end

function cmpN(f, generator, typ)
  function cmpNewtons(N1, N2)
    n = N1.n
    d = [abs(N1.a[i] - N2.a[i]) for i in 1:n]
    maximum(d)
  end

  for i in 0:4
    @printf("|     %d     |", i+5)
    for n in 2:9
      @printf("     %d     |", n*5 + i)
    end
    @printf("\n|")
    for n in i+5:5:49
      N1, N2 = cons_Newtons(n, generator, f, typ)
      @printf("%.4e | ", cmpNewtons(N1, N2))
    end
    println("\n-------------------------------------------------------------------------------------------------------------------")
  end
end

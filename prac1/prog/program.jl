# Franciszek Zdobylak nr ind. 310313
#
# Plik zawierający realizację zadania P1.18

include("repr.jl")
include("tstinterface.jl")
using Printf

# funkcje które będę przybliżał
f1(x) = 1 / (1 + 25 * x * x)
f2(x) = atan(x)
# funkcja z arykułu Wernera
f3(x) = (sin(x) + cos(x) - 1) / x

### TESTY 1
function tests4_1()
  println("\n\n------- TESTY 1 -------\n")
  # testy f1 w punkcie x = 0
  # f1(0) = 1
  # będę sprawdzał dla węzłów różnych od 0 z przedziału [-1, 1]
  #
  function compare_ans(case, f)
    ans = [ev(case.L, 0), ev(case.LB, 0), ev(case.N, 0)]
    ans = [1.0 - x for x in ans]
  end

  @printf("f1(x) = 1 / (1 + 25*x*x)\n")
  @printf("\nWyniki dla f1 dla węzłów równoodległych w pojedynczej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 4:4:4*12
    ans = test_case(n, genEqual, 1, f1, Float32, compare_ans)
  end

  @printf("\n\nWyniki dla f1 dla węzłów równoodległych w podwójnej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 4:4:4*12
    ans = test_case(n, genEqual, 1, f1, Float64, compare_ans)
  end

  @printf("\n\nWyniki dla f1 dla węzłów Chebysheva w pojedynczej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 4:4:4*12
    ans = test_case(n, genChebyshevNodes, 1, f1, Float32, compare_ans)
  end

  @printf("\n\nWyniki dla f1 dla węzłów Chebysheva w podwójnej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 4:4:4*12
    ans = test_case(n, genChebyshevNodes, 1, f1, Float64, compare_ans)
  end

  @printf("\n\nPrzykładowy wynik dla węzłów które mogą trafiać w punkt w którym liczymy wartość funkcji:\n")
  @printf("\nWyniki dla f1 dla węzłów równoodległych w pojedynczej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 5:5:50
    ans = test_case(n, genEqual, 1, f1, Float32, compare_ans)
  end

  @printf("\n\nWyniki dla f1 dla węzłów równoodległych w podwójnej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 5:5:50
    ans = test_case(n, genEqual, 1, f1, Float64, compare_ans)
  end

  function compare_ans2(case, f)
    ans = [ev(case.L, 0), ev(case.LB, 0), ev(case.N, 0)]
    ans = [0.0 - x for x in ans]
  end

  @printf("\n\nf2(x) = atan(x)\n")
  @printf("\nWyniki dla f2 dla węzłów równoodległych w pojedynczej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 4:4:4*12
    ans = test_case(n, genEqual, 1, f2, Float32, compare_ans2)
  end

  @printf("\n\nWyniki dla f2 dla węzłów równoodległych w podwójnej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 4:4:4*12
    ans = test_case(n, genEqual, 1, f2, Float64, compare_ans2)
  end

  @printf("\n\nWyniki dla f2 dla węzłów Chebysheva w pojedynczej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 4:4:4*12
    ans = test_case(n, genChebyshevNodes, 1, f2, Float32, compare_ans2)
  end

  @printf("\n\nWyniki dla f2 dla węzłów Chebysheva w podwójnej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 4:4:4*12
    ans = test_case(n, genChebyshevNodes, 1, f2, Float64, compare_ans2)
  end

  @printf("\n\nf3(x) = (sin(x) + cos(x) - 1) / x\n")
  @printf("\nWyniki dla f3 dla węzłów równoodległych w pojedynczej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 4:4:4*12
    ans = test_case(n, genEqual, 1, f3, Float32, compare_ans)
  end

  @printf("\n\nWyniki dla f3 dla węzłów równoodległych w podwójnej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 4:4:4*12
    ans = test_case(n, genEqual, 1, f3, Float64, compare_ans)
  end

  @printf("\n\nWyniki dla f3 dla węzłów Chebysheva w pojedynczej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 4:4:4*12
    ans = test_case(n, genChebyshevNodes, 1, f3, Float32, compare_ans)
  end

  @printf("\n\nWyniki dla f3 dla węzłów Chebysheva w podwójnej precyzji")
  @printf("\n  węzły\t|  f(0) - L(0)\t| f(0) - LBC(0)\t| f(0) - N(0)")
  for n in 4:4:4*12
    ans = test_case(n, genChebyshevNodes, 1, f3, Float64, compare_ans)
  end
end

### TESTY 2
function tests4_2()
  println("\n\n------- TESTY 2 -------")
  function sum(x)
    s = Float64(0)
    for i in x
      s += i
    end
    return s
  end

  function average(x)
    return sum(x) / length(x)
  end

  # liczę średnią odległość wilomianu od funkcji w zależności od liczby węzłów

  # punkty w których będę liczył wartości funkcji
  # (losowe wartości z przedziału (-0.5, 0.5))
  # (sprawdzam wewnątrz przedziału, bo na końcach są większe rozbieżności)
  points = [x*0.5 - 0.25 for x in rand(100)]

  function compare_ans(case, f)
    dL = average(sort([abs(f(i) - ev(case.L, i)) for i in points])[10:90])
    dN = average(sort([abs(f(i) - ev(case.N, i)) for i in points])[10:90])
    dLB = average(sort([abs(f(i) - ev(case.LB, i)) for i in points])[10:90])
    return [dL, dLB, dN]
  end

  @printf("\n\nWyniki dla f1 dla węzłów równoodległych w pojedynczej precyzji:")
  @printf("\n  węzły\t|  f(x) - L(x)\t| f(x) - LBC(x)\t| f(x) - N(x)")
  for n in 5:5:50
    test_case(n, genEqual, 1, f1, Float32, compare_ans)
  end

  @printf("\n\nWyniki dla f1 dla węzłów równoodległych w podwójnej precyzji:")
  @printf("\n  węzły\t|  f(x) - L(x)\t| f(x) - LBC(x)\t| f(x) - N(x)")
  for n in 5:5:50
    test_case(n, genEqual, 1, f1, Float64, compare_ans)
  end

  @printf("\n\nWyniki dla f1 dla węzłów Chebysheva w pojedynczej precyzji:")
  @printf("\n  węzły\t|  f(x) - L(x)\t| f(x) - LBC(x)\t| f(x) - N(x)")
  for n in 5:5:50
    test_case(n, genChebyshevNodes, 1, f1, Float32, compare_ans)
  end

  @printf("\n\nWyniki dla f1 dla węzłów Chebysheva w podwójnej precyzji:")
  @printf("\n  węzły\t|  f(x) - L(x)\t| f(x) - LBC(x)\t| f(x) - N(x)")
  for n in 5:5:50
    test_case(n, genChebyshevNodes, 1, f1, Float64, compare_ans)
  end

  @printf("\n\nWyniki dla  f2 dla węzłów równoodległych w pojedynczej precyzji:")
  @printf("\n  węzły\t|  f(x) - L(x)\t| f(x) - LBC(x)\t| f(x) - N(x)")
  for n in 5:5:50
    test_case(n, genEqual, 1, f2, Float32, compare_ans)
  end

  @printf("\n\nWyniki dla  f2 dla węzłów równoodległych w podwójnej precyzji:")
  @printf("\n  węzły\t|  f(x) - L(x)\t| f(x) - LBC(x)\t| f(x) - N(x)")
  for n in 5:5:50
    test_case(n, genEqual, 1, f2, Float64, compare_ans)
  end

  @printf("\n\nWyniki dla  f2 dla węzłów Chebysheva w pojedynczej precyzji:")
  @printf("\n  węzły\t|  f(x) - L(x)\t| f(x) - LBC(x)\t| f(x) - N(x)")
  for n in 5:5:50
    test_case(n, genChebyshevNodes, 1, f2, Float32, compare_ans)
  end

  @printf("\n\nWyniki dla  f2 dla węzłów Chebysheva w podwójnej precyzji:")
  @printf("\n  węzły\t|  f(x) - L(x)\t| f(x) - LBC(x)\t| f(x) - N(x)")
  for n in 5:5:50
    test_case(n, genChebyshevNodes, 1, f2, Float64, compare_ans)
  end

  # w ostatniej funkcji zmieniłem trochę ilość punktów tak aby zawsze była parzyst
  # (przy sprawdzaniu błędu gdy liczba punktów była nieparzysta coś się psuło)
  @printf("\n\nWyniki dla f3 węzłów równoodległych w pojedynczej precyzji:")
  @printf("\n  węzły\t|  f(x) - L(x)\t| f(x) - LBC(x)\t| f(x) - N(x)")
  for n in 4:4:48
    test_case(n, genEqual, 1, f3, Float32, compare_ans)
  end

  @printf("\n\nWyniki dla f3 węzłów równoodległych w podwójnej precyzji:")
  @printf("\n  węzły\t|  f(x) - L(x)\t| f(x) - LBC(x)\t| f(x) - N(x)")
  for n in 4:4:48
    test_case(n, genEqual, 1, f3, Float64, compare_ans)
  end

  @printf("\n\nWyniki dla f3 węzłów Chebysheva w pojedynczej precyzji:")
  @printf("\n  węzły\t|  f(x) - L(x)\t| f(x) - LBC(x)\t| f(x) - N(x)")
  for n in 4:4:48
    test_case(n, genChebyshevNodes, 1, f3, Float32, compare_ans)
  end

  @printf("\n\nWyniki dla f3 węzłów Chebysheva w podwójnej precyzji:")
  @printf("\n  węzły\t|  f(x) - L(x)\t| f(x) - LBC(x)\t| f(x) - N(x)")
  for n in 4:4:48
    test_case(n, genChebyshevNodes, 1, f3, Float64, compare_ans)
  end
end

### TESTY 3

# testy zamiany postaci Lagrange'a na postać Newtona
# będę porównywał wartości Newtona policzonego wprost i z przekształcenia

function tests3()
  println("\n\n------- TESTY 3 -------\n")

  @printf("\nWęzły równoodległe funkcja f1, pojedyncza precyzja\n")
  cmpN(f1, genEqual, Float32)
  @printf("\nWęzły równoodległe funckja f1, podwójna precyzja\n")
  cmpN(f1, genEqual, Float64)
  
  @printf("\nWęzły Czebysheva funkcja f1, pojedyncza precyzja\n")
  cmpN(f1, genChebyshevNodes, Float32)
  @printf("\nWęzły Czebysheva funckja f1, podwójna precyzja\n")
  cmpN(f1, genChebyshevNodes, Float64)
  
  @printf("\nWęzły równoodległe funkcja f2, pojedyncza precyzja\n")
  cmpN(f2, genEqual, Float32)
  @printf("\nWęzły równoodległe funckja f2, podwójna precyzja\n")
  cmpN(f2, genEqual, Float64)
  
  @printf("\nWęzły Czebysheva funkcja f2, pojedyncza precyzja\n")
  cmpN(f2, genChebyshevNodes, Float32)
  @printf("\nWęzły Czebysheva funckja f2, podwójna precyzja\n")
  cmpN(f2, genChebyshevNodes, Float64)
  
  @printf("\nWęzły równoodległe funkcja f3, pojedyncza precyzja\n")
  cmpN(f3, genEqual, Float32)
  @printf("\nWęzły równoodległe funckja f3, podwójna precyzja\n")
  cmpN(f3, genEqual, Float64)
  
  @printf("\nWęzły Czebysheva funkcja f3, pojedyncza precyzja\n")
  cmpN(f3, genChebyshevNodes, Float32)
  @printf("\nWęzły Czebysheva funckja f3, podwójna precyzja\n")
  cmpN(f3, genChebyshevNodes, Float64)
  
end

tests4_1() # testy opisane w rozdziale 4.1
tests4_2() # testy opisane w rozdziale 4.2
tests3() # testy opisane w rozdziale 3

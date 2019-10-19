# Franciszek Zdobylak
# przykładowy program w julii

using Printf
using PyPlot

x = 100
y = 3.14
z = "jakiś string"
@printf("Integer: %d\nFloat:%f\nString:%s\n", x, y, z)

xrange = 1:50
values = [x^2 for x in 1:50]

plot(xrange, values, linewidth=2.0, linestyle="-")
show()

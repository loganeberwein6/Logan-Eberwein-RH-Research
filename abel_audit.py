import math
from sympy import factorint

for X in [30, 100, 210, 500, 1000, 2310]:
    lam = {m: math.log(next(iter(factorint(m))))
           for m in range(2, X) if len(factorint(m)) == 1}
    sint = sum(lam[m] * lam[n] / math.sqrt(m*n)
               for m in lam for n in lam if m*n < X)
    total = sum(lam[m] * lam[n] / math.sqrt(m*n)
                for m in lam for n in lam)
    psi2 = sum(lam[m] * lam[n]
               for m in lam for n in lam if m*n <= X)
    psi = sum(lam.values())
    print(X, sint / total, psi2 / (psi * psi), 2 * psi2 / (psi * psi))

def all_ones_original(X):
    return sum(-1 if m*n < X else 1
               for m in range(2, X) for n in range(2, X))

for X in [30, 100, 210, 500, 1000, 2310]:
    print(X, all_ones_original(X), all_ones_original(X) / X**1.5)

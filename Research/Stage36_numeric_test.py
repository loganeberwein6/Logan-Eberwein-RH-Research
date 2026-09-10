import math

beta_test, gamma_test = 0.8, 21.022

def explicit_formula_prediction(X, rho):
    rp1 = rho + 1
    return X ** rp1.real * math.cos(rp1.imag * math.log(X)) / abs(rp1)

def Q_exact(X, beta, gamma):
    return sum(
        (-1 if m * n < X else 1)
        * m ** (beta - 0.5) * math.cos(gamma * math.log(m))
        * n ** (beta - 0.5) * math.cos(gamma * math.log(n))
        for m in range(2, X) for n in range(2, X)
    )

rho_critical = complex(0.5, gamma_test)
rho_offline = complex(0.8, gamma_test)
xs = [30, 100, 210, 500, 1000]

print("Testing explicit formula for beta=0.8, gamma=21.022:")
print("Using RH prediction: rho = 1/2 + i*gamma")
print(f"rho+1 = {rho_critical + 1}, |rho+1| = {abs(rho_critical + 1):.4f}")
print(f"{'X':>6} {'Q_exact':>12} {'Q_pred_RH':>12} {'ratio':>12}")
for X in xs:
    q = Q_exact(X, 0.5, gamma_test)
    pred = explicit_formula_prediction(X, rho_critical)
    print(f"{X:>6} {q:>12.4f} {pred:>12.4f} {q/pred if abs(pred) > 0.1 else float('nan'):>12.4f}")

print("\nNow testing OFF-LINE: beta=0.8, gamma=21.022")
print(f"rho+1 = {rho_offline + 1}, predicted growth = X^{rho_offline.real + 1:.1f}")
print(f"{'X':>6} {'Q_exact(0.8)':>14} {'Q_pred_off':>14} {'ratio':>12}")
for X in xs:
    q = Q_exact(X, 0.8, gamma_test)
    pred = explicit_formula_prediction(X, rho_offline)
    print(f"{X:>6} {q:>14.4f} {pred:>14.4f} {q/pred if abs(pred) > 0.1 else float('nan'):>12.4f}")

print("\nMixed test: Q with beta=0.8, predicted by critical rho")
for X in xs:
    q = Q_exact(X, 0.8, gamma_test)
    pred = explicit_formula_prediction(X, rho_critical)
    print(f"X={X}: Q/Q_crit={q/pred:.4f}, X^0.3={X**0.3:.4f}, ratio/X^0.3={q/pred/X**0.3:.4f}")

gamma_zeros = [14.1347, 21.0220, 25.0109, 30.4249, 32.9351]
print("\nTesting: does gamma = zeta-zero imaginary part give slower growth?")
print("gamma        exponent(100->1000)   Q/X^1.5 at X=1000")
for gamma in gamma_zeros + [10.0, 15.0, 20.0]:
    q100 = Q_exact(100, 0.5, gamma)
    q1000 = Q_exact(1000, 0.5, gamma)
    exponent = math.log(abs(q1000) / abs(q100)) / math.log(10)
    print(f"{gamma:>8.4f} {exponent:>22.3f} {q1000 / 1000**1.5:>22.4f}")

print("\nFor beta=0.8: does the zero location matter?")
for gamma in gamma_zeros[:3]:
    q100 = Q_exact(100, 0.8, gamma)
    q1000 = Q_exact(1000, 0.8, gamma)
    exponent = math.log(abs(q1000) / abs(q100)) / math.log(10)
    print(f"gamma={gamma:.4f}: growth exp={exponent:.3f}")

print("\nGram matrix eigenvalue test")
for X in [10, 30, 100]:
    support = list(range(2, X))
    n = len(support)
    matrix = [[-1 if m * q < X else 1 for q in support] for m in support]
    gram = [[sum(matrix[i][k] * matrix[j][k] for k in range(n))
             for j in range(n)] for i in range(n)]
    # Power iteration gives the largest eigenvalue without external packages.
    vector = [1.0] * n
    for _ in range(250):
        image = [sum(gram[i][j] * vector[j] for j in range(n)) for i in range(n)]
        scale = max(abs(value) for value in image)
        vector = [value / scale for value in image]
    image = [sum(gram[i][j] * vector[j] for j in range(n)) for i in range(n)]
    max_eigenvalue = sum(vector[i] * image[i] for i in range(n)) / sum(value * value for value in vector)
    operator_norm = math.sqrt(max_eigenvalue)
    print(f"X={X}: n={n}, max eig(G)={max_eigenvalue:.4f}, "
          f"||M||={operator_norm:.4f}, sqrt(n)={math.sqrt(n):.4f}, "
          f"ratio={operator_norm / math.sqrt(n):.4f}")

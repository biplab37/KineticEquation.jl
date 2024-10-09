ϵ(t, k, p::Pulse) = sqrt(sum((k - p.A(t)) .^ 2 .+ 0.0))
λ(t, k, p::Pulse) = (p.E(t)[1] * (k[2] - p.A(t)[2]) - p.E(t)[2] * (k[1] - p.A(t)[1])) / ϵ(t, k, p)^2

function odes!(dx, x, arg, t)
    dx[1] = 0.5 * λ(t, arg[1], arg[2]) * x[2]
    dx[2] = λ(t, arg[1], arg[2]) * (1 - 2x[1]) - 2 * ϵ(t, arg[1], arg[2]) * x[3]
    dx[3] = 2ϵ(t, arg[1], arg[2]) * x[2]
end

function odes(x, arg, t)
    dx = similar(x)

    dx[1] = 0.5 * λ(t, arg[1], arg[2]) * x[2]
    dx[2] = λ(t, arg[1], arg[2]) * (1 - 2x[1]) - 2 * ϵ(t, arg[1], arg[2]) * x[3]
    dx[3] = 2ϵ(t, arg[1], arg[2]) * x[2]

    return dx
end

## Generalized version
ϵ_gen(t, k, p::Pulse) = abs(ff(momentum_evolution(k, t, p.A))) / 0.8657547962164611

function λ_gen(t, k, p::Pulse)
    P = k .- p.A(t)
    E_field = p.E(t)
    ϵ = ϵ_gen(t, k, p)
    return (E_field[1] * (cos(sqrt(3) * P[1] / 2) * cos(P[2] / 2) - cos(P[2])) / sqrt(3) + E_field[2] * sin(sqrt(3) * P[1] / 2) * sin(P[2] / 2)) / ϵ^2
end

function odes_gen!(dx, x, arg, t)
    dx[1] = 0.5 * λ_gen(t, arg[1], arg[2]) * x[2]
    dx[2] = λ_gen(t, arg[1], arg[2]) * (1 - 2x[1]) - 2 * ϵ_gen(t, arg[1], arg[2]) * x[3]
    dx[3] = 2ϵ_gen(t, arg[1], arg[2]) * x[2]
end

function odes_gen(x, arg, t)
    dx = similar(x)

    dx[1] = 0.5 * λ_gen(t, arg[1], arg[2]) * x[2]
    dx[2] = λ_gen(t, arg[1], arg[2]) * (1 - 2x[1]) - 2 * ϵ_gen(t, arg[1], arg[2]) * x[3]
    dx[3] = 2ϵ_gen(t, arg[1], arg[2]) * x[2]

    return dx
end

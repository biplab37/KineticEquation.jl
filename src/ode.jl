ϵ(t, k, p::Pulse) = sqrt(sum((k - p.A(t)) .^ 2 .+ 0.5))
λ(t, k, p::Pulse) = (p.E(t)[1] * (k[2] - p.A(t)[2]) - p.E(t)[2] * (k[1] - p.A(t)[1])) / ϵ(t, k, p)^2

function odes!(dx, x, arg, t)
    dx[1] = 0.5 * λ(t, arg[1], arg[2]) * x[2]
    dx[2] = λ(t, arg[1], arg[2]) * (1 - 2x[1]) - 2 * ϵ(t, arg[1], arg[2]) * x[3]
    dx[3] = 2ϵ(t, arg[1], arg[2]) * x[2]
end

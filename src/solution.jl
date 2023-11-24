function f_atk(k1, k2, p::Pulse, initial_value=[0.0, 0.0, 0.0])
    if k1 == 0 && k2 == 0
        return initial_value
    end
    prob = ODEProblem(odes!, initial_value, (p.start, p.finish), [[k1, k2], p])
    return solve(prob, Tsit5())(p.finish)
end

function distribution_f(kxrange, kyrange, p::Pulse)
    dist_f = zeros(length(kxrange), length(kyrange))
    for (i, kx) in enumerate(kxrange)
        for (j, ky) in enumerate(kyrange)
            dist_f[i, j] = f_atk(kx, ky, p)[1]
        end
    end
    return dist_f
end

function fsection_x(kx, kyrange, p::Pulse)
    dist_f = zeros(length(kyrange))
    for (j, ky) in enumerate(kyrange)
        dist_f[j] = f_atk(kx, ky, p)[1]
    end
    return dist_f
end

function fsection_y(kxrange, ky, p::Pulse)
    dist_f = zeros(length(kxrange))
    for (i, kx) in enumerate(kxrange)
        dist_f[i] = f_atk(kx, ky, p)[1]
    end
    return dist_f
end

export f_atk, distribution_f, fsection_x, fsection_y

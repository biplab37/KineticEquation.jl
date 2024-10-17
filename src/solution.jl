"""
    f_atk(k1, k2, p::Pulse, initial_value=[0.0, 0.0, 0.0])

Calculate the distribution function for a given pulse and k1, k2 values. Returns f u and v.
"""
function f_atk(k1, k2, p::Pulse, initial_value=[0.0, 0.0, 0.0])
    if k1 == 0 && k2 == 0
        return initial_value
    end
    prob = ODEProblem(odes!, initial_value, (p.start, p.finish), ([k1, k2], p))
    return solve(prob, Tsit5())(p.finish)
end

"""
    distribution_f(kxrange, kyrange, p::Pulse)

Calculate the distribution function for a given pulse and range of kx and ky values.
Returns the distribution function as a 2D array.
"""
function distribution_f(kxrange, kyrange, p::Pulse)
    dist_f = zeros(length(kxrange), length(kyrange))
    for (i, kx) in enumerate(kxrange)
        for (j, ky) in enumerate(kyrange)
            dist_f[i, j] = f_atk(kx, ky, p)[1]
        end
    end
    return dist_f
end

"""
    distribution_list(kxrange, kyrange, p::Pulse)

Calculate the distribution function for a given pulse and range of kx and ky values.
Returns an array containg the kx, ky and f(kx, ky) values.
"""
function distribution_list(kxrange, kyrange, p::Pulse)
    dist_f = zeros(length(kxrange) * length(kyrange), 3)
    i = 1
    for kx in kxrange
        for ky in kyrange
            dist_f[i, :] .= [kx, ky, f_atk(kx, ky, p)[1]]
            i += 1
        end
    end
    return dist_f
end

"""
    fsection_x(kx, kyrange, p::Pulse)

Calculate the distribution function for a given pulse and range of ky values for a given kx value.
Returns the distribution function as a 1D array.
"""
function fsection_x(kx, kyrange, p::Pulse)
    dist_f = zeros(length(kyrange))
    for (j, ky) in enumerate(kyrange)
        dist_f[j] = f_atk(kx, ky, p)[1]
    end
    return dist_f
end

"""
    fsection_y(kxrange, ky, p::Pulse)

Calculate the distribution function for a given pulse and range of kx values for a given ky value.
Returns the distribution function as a 1D array.
"""
function fsection_y(kxrange, ky, p::Pulse)
    dist_f = zeros(length(kxrange))
    for (i, kx) in enumerate(kxrange)
        dist_f[i] = f_atk(kx, ky, p)[1]
    end
    return dist_f
end

function f_atk_func(k1, k2, t, p::Pulse, initial_value=[0.0, 0.0, 0.0])::Float64
    if k1 == 0 && k2 == 0
        return initial_value[1]
    end
    prob = ODEProblem(odes!, initial_value, (p.start, p.finish), [[k1, k2], p])
    return solve(prob, Tsit5())(t)[1]
end

function f(k)
    sol = f_atk_func(k[1], k[2], ConstantPulse(), [0.0, 0.0, 0.0])
    return sol(0.1)[1]
end

function density(t, p::Pulse, initial_value=[0.0, 0.0, 0.0], region=[-10.0 10.0; -10.0 10.0])
    return hcubature(k -> f_atk_func(k[1], k[2], t, p, initial_value), [-10.0, -10.0], [10.0, 1.0], rtol=1e-3)[1]
end
function density(trange::AbstractVector, p::Pulse, initial_value=[0.0, 0.0, 0.0], region=[-1.0 1.0; -1.0 1.0])
    d_list = zeros(length(trange))
    for (i, t) in enumerate(trange)
        d_list[i] = density(t, p, initial_value, region)
    end
    return d_list
end

export f_atk, distribution_f, fsection_x, fsection_y, distribution_list, density

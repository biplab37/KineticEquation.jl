## Implementation of the method described in paper arXiv:1607.04198v1

"""
    ff(k; a = 1.0)

Form factor for graphene. `a` is the lattice spacing.
"""
function ff(k::Vector{Float64}; a=1.0)
    return exp(im * a * k[1] / √3) + 2 * exp(-im * a * k[1] / (2√3)) * cos(a * k[2] / 2)
end

function H0(k::Vector{Float64}; a=1.0, ϵh=1.0)
    return [0 -ϵh*ff(k, a=a); -ϵh*conj(ff(k, a=a)) 0]
end

function Uk(k; a=1.0)
    etheta = sqrt(ff(k, a=a) / abs(ff(k, a=a)))
    return 1 / √2 * [etheta -etheta; conj(etheta) conj(etheta)]
end

function Uk_dagger(k; a=1.0)
    etheta = sqrt(ff(k, a=a) / abs(ff(k, a=a)))
    return 1 / √2 * [conj(etheta) etheta; -conj(etheta) etheta]
end

function momentum_evolution(k0, t, A::Function)
    return k0 .- A(t)
end

## Discretization in time to solve the ODE
function fields_atk(k0, initial, Fields::Function, timerange)
    time_data = zeros(Complex, length(timerange) + 1, length(initial))
    delta_t = timerange[2] - timerange[1]
    time_data[1, :] = initial
    for (i, t) in enumerate(timerange)
        k = momentum_evolution(k0, t, Fields)
        time_data[i+1, :] = time_data[i, :] .+ delta_t * new_time_step(k, time_data[i, :])
    end
    return time_data
end

function fields_atk!(time_data, k0, initial, pulse::Pulse)
    timerange = range(pulse.start, pulse.finish, length=size(time_data)[1] - 1)
    delta_t = timerange[2] - timerange[1]
    time_data[1, :] = initial
    for (i, t) in enumerate(timerange)
        k = momentum_evolution(k0, t, pulse.A)
        time_data[i+1, :] = time_data[i, :] .+ delta_t * new_time_step(k, time_data[i, :])
    end
    return nothing
end

function wave_function_atk(k0, initial, Fields::Function, timerange)
    N = length(initial)
    data = zeros(Complex, length(timerange) + 1, 2 * N)
    delta_t = timerange[2] - timerange[1]
    data[1, 1:N] = initial
    for (i, t) in enumerate(timerange)
        momenta = momentum_evolution(k0, t, Fields)
        Udagger = Uk_dagger(momenta)
        ab_basis = data[i, 1:N] .+ delta_t * new_time_step(momenta, data[i, 1:N])
        cv_basis = Udagger * ab_basis
        data[i+1, 1:N] = ab_basis
        data[i+1, N+1:2N] = cv_basis
    end
    return data
end

function new_time_step(momenta, x)
    return -im * (10 / 6.5) * H0(momenta) * x
end

export fields_atk, wave_function_atk, fields_atk!

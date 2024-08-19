## Implementation of the method described in paper arXiv:1607.04198v1

"""
    ff(k; a = 1.0)

Form factor for graphene. `a` is the lattice spacing.
"""
function ff(k::Vector{Float64,1}; a=1.0)
    return exp(im * a * k[1] / √3) + 2 * exp(-im * a * k[1] / (2√3)) * cos(a * k[2] / 2)
end

function H0(k::Vector{Float64,1}; a=1.0, ϵh=1.0)
    return [0 -ϵh*ff(k, a=a); -ϵh*conj(ff(k, a=a)) 0]
end

function Uk(k; a=1.0)
    etheta = sqrt(ff(k, a=a) / abs(ff(k, a=a)))
    return 1 / √2 * [etheta - etheta; conj(etheta) conj(etheta)]
end

function momentum_evolution(k0, t, A::Function)
    return k0 - 1.609e-19 * A(t) / (6.626e-26)
end

## Discretization in time to solve the ODE
function fields_atk(initial::Vector{Float64,1}, Fields::Function, timerange)
    for (i, t) in enumerate(timerange)
        @assert "Not implemented yet"
    end
end

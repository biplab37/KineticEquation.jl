abstract type Pulse end

"""
    CustomPulse(args, E, A, start, finish)

This custom struct can be used to define a custom pulse. You need to pass the function for the electric field and the vector potential. The functions can take any number of arguments but the first argument should be time. The `args` should be passed as a tuple or an array.
"""
Base.@kwdef mutable struct CustomPulse <: Pulse
    args::Any
    E::Function
    A::Function
    start::Real = 0.0
    finish::Real = 1.0
    function Pulse(args, E, A, start, finish)
        E1 = try
            t -> E(t, args...)
        catch E
        end
        A1 = try
            t -> A(t, args...)
        catch A
        end
        new(args, E1, A1, start, finish)
    end
end

Base.@kwdef mutable struct SauterPulse <: Pulse
    T = 1.0
    Amp = 0.1
    E = t -> [Amp / cosh(t / T)^2, 0.0]
    A = t -> [-Amp * T * tanh(t / T), 0.0]
    start = -5.0
    finish = 5.0
end

Base.@kwdef mutable struct ConstantPulse <: Pulse
    Amp = 0.1
    E = t -> [Amp, 0.0]
    A = t -> [-Amp * t, 0.0]
    start = 0.0
    finish = 1.0
end

Base.@kwdef mutable struct HarmonicPulse <: Pulse
    ω = 1.0
    Amp = 0.01
    E = t -> Amp * [sin(ω * t), 0.0]
    A = t -> Amp * [(1 - cos(ω * t)) / ω, 0.0]
    start = 0.0
    finish = 2π
end

Base.@kwdef struct CircularGaussianPulse <: Pulse
    Amp = 1.0
    carier_freq::Real = 1.0
    time_width = 1.0
    bias = 0.0
    A = t -> Amp * exp(-t^2 / (2 * time_width^2)) * [-sin(carier_freq * t + bias), cos(carier_freq * t + bias)]
    start = -5.0
    finish = 5.0
end

# Base.@kwdef mutable struct GaussianPulse <: Pulse
#     Amp = 0.1
#     σ = 1.0
#     E = t -> [Amp * exp(-t^2 / (2 * σ^2)), 0.0]
#     A = t -> [-Amp * t * exp(-t^2 / (2 * σ^2)), 0.0]
#     start = -5.0
#     finish = 5.0
# end

# TODO: Complete the implementation of GaussianHarmonicPulse
# Base.@kwdef mutable struct GaussianHarmonicPulse <: Pulse
#     ω = 1.0
#     Amp = 0.1
#     σ = 1.0
#     E = t -> Amp * [exp(-t^2 / (2 * σ^2)) * cos(ω * t), 0.0]

export Pulse, CustomPulse, SauterPulse, ConstantPulse, HarmonicPulse, CircularGaussianPulse

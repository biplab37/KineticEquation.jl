abstract type Pulse end

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

export Pulse, CustomPulse, SauterPulse, ConstantPulse, HarmonicPulse

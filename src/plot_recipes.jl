@recipe function f(pulse::LinearPulse, dt=0.01)
    labels := ["A(t)" "E(t)"]
    xlabel := "Time"
    trange = pulse.start:dt:pulse.finish
    trange, [first.(pulse.A.(trange)) first.(pulse.E.(trange))]
end

@recipe function plot_circularly_polarised_pulse(pulse::CircularPulse, dt=0.01)
    labels := ["E(t)_x " "E(t)_y" "A(t)_x" "A(t)_y"]
    xlabel := "Time"
    trange = pulse.start:dt:pulse.finish
    trange, [first.(pulse.E.(trange))  last.(pulse.E.(trange)) first.(pulse.A.(trange)) last.(pulse.A.(trange))]
end

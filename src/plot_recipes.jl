@recipe function f(pulse::Pulse, dt=0.01)
    labels := ["A(t)" "E(t)"]
    xlabel := "Time"
    trange = pulse.start:dt:pulse.finish
    trange, [first.(pulse.A.(trange)) first.(pulse.E.(trange))]
end

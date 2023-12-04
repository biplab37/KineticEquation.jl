function prod_rate(amp, pulse::Pulse)
    region = calc_region(amp, pulse)
    return integrate_region((kx, ky) -> distribution_f(kx, ky, pulse), region)
end


#TODO: Improve this functions to calculate the region of non-zero 
# distribution function for a given pulse.
function calc_region(amp, pulse::Pulse)
    return amp * [-1.0 1.0; -1.0 1.0]
end

function prod_rate(amp, pulse::Pulse)
    region = calc_region(amp, pulse)
    return integrate_region((kx, ky) -> distribution_f(kx, ky, pulse), region)
end


#TODO: Improve this functions to calculate the region of non-zero 
# distribution function for a given pulse.
function calc_region(amp, pulse::Pulse)
    return amp * [-1.0 1.0; -1.0 1.0]
end

function prod_rate(amp_range::AbstractVector, pulse::Pulse)
    rates = zeros(length(amp_range))
    for (i, amp) in enumerate(amp_range)
        rates[i] = prod_rate(amp, pulse)
    end
end

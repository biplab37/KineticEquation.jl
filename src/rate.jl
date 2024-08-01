function prod_rate(pulse::Pulse)
    region = calc_region(pulse)
    return integrate_region(k -> distribution_f(k[1], k[2], pulse), region)
end


#TODO: Improve this functions to calculate the region of non-zero 
# distribution function for a given pulse.
function calc_region(pulse::Pulse)
    return [-100.0 100.0; -10.0 10.0]
end

function prod_rate(amp_range::AbstractVector, pulse::Pulse)
    rates = zeros(length(amp_range))
    for (i, amp) in enumerate(amp_range)
        pulse.Amp = amp
        rates[i] = prod_rate(amp, pulse)
    end
end

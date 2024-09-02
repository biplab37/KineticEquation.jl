# This file contains code to show the classical path of an electron given an external pulse.

function classical_path_data!(data_table, start_momentum, pulse::Pulse, timerange)
    if size(data_table)[1] != length(timerange)
        @error "data_table and timerange must have the same length"
    end
    for i in eachindex(timerange)
        data_table[i, 1:2] = momentum_evolution(start_momentum, timerange[i], pulse.A)
        data_table[i, 3] = abs(ff(data_table[i, 1:2]))
    end
    return nothing
end

export classical_path_data!

function A_values(k, k0; a=1.0, ϵh=1.0)
    fk = ff(k, a=a)
    eit = ff(k0) / abs(ff(k0))
    factor = 10 / 6.58
    A1 = -ϵh * factor * (fk / eit + conj(fk) * eit) / 2.0
    A2 = -ϵh * factor * (fk / eit - conj(fk) * eit) / 2.0
    A3 = ϵh * factor * (fk / eit - conj(fk) * eit) / 2.0
    A4 = ϵh * factor * (fk / eit + conj(fk) * eit) / 2.0

    return A1, A2, A3, A4
end

function SB_diffeqn(density, param, t)
    k = momentum_evolution(param[1], t, param[2].A)
    A1, A2, A3, A4 = A_values(k, param[1])
    dρ_cv = -im * density[1] * (conj(A4 - A1)) - im * A3 * (1 - density[2] - density[3]) - density[1] * param[3]
    dρ_e = -2 * imag(conj(A3) * density[1]) - density[2] * param[4]
    dρ_h = 2 * imag(conj(A2) * density[1]) - density[3] * param[5]

    return [dρ_cv, dρ_e, dρ_h]
end

export SB_diffeqn

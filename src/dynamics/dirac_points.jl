# Returns the Dirac points

function Dirac_points()
    dp1 = [0, 4π/3]
    dp2 = [2π/sqrt(3), 2π/3]
    return [dp1, -dp1, dp2, [1, -1] .* dp2, [-1, 1] .* dp2, [-1, -1] .* dp2]
end

function integrate_near_Dirac_point(func, radius, dirac_point, integrate = integrate)
    integrand(y) = integrate(x->func(x,y), dirac_point[1]-y, dirac_point[1]+y)
    return integrate(integrand, dirac_point[2] - radius, dirac_point[2] + radius)
end

export Dirac_points, integrate_near_Dirac_point
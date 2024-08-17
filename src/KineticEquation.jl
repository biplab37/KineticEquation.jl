module KineticEquation

using OrdinaryDiffEq: ODEProblem, solve, Tsit5
using HCubature
using RecipesBase

include("custom_types.jl")
include("helper_functions.jl")
include("ode.jl")
include("solution.jl")
include("rate.jl")
include("plot_recipes.jl")

end

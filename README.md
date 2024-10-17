# KineticEquation

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://biplab37.github.io/KineticEquation.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://biplab37.github.io/KineticEquation.jl/dev/)
[![Build Status](https://github.com/biplab37/KineticEquation.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/biplab37/KineticEquation.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/biplab37/KineticEquation.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/biplab37/KineticEquation.jl)

This repo contains the code to solve the ordinary differential equations for the electron-hole paiproduction in Graphene. It uses the julia package `OrdnaryDiffEq` to solve the system of ordinary differential equations. There is alsa section for the appximate solution to these equations as well.

## Usage
The package can be installed using the following command.
```julia
]add https://github.com/biplab37/KineticEquation.jl
```
Then start using it with,
```julia
using KineticEquation
```

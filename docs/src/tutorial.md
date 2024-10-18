# Tutorial
---
This page contains basic usage. For details see respective documentations on Pulse, ODEs etc.
Once installed the package can be used as follows,
```julia
using KineticEquation
```
Start with defining a pulse
```julia
pulse = ConstantPulse()
```
The above command will create a constant pulse, you can customise the pulse. The package also provides recipe for plotting. So if you are using `Plots` package then you can plot the pulse,
```julia
plot(pulse)
```

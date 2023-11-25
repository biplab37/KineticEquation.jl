using KineticEquation
using Test

@testset "KineticEquation.jl" begin
    @testset "Pulse" begin
        @testset "CustomPulse" begin
            p = CustomPulse(1, (t, a) -> [1.0, 0.0], (t, a) -> [0.0, 1.0])
            @test p.E(0.0) ≈ [1.0, 0.0]
            @test p.A(0.0) ≈ [0.0, 1.0]
        end
        @testset "SauterPulse" begin
            p = SauterPulse()
            @test p.E(0.0) ≈ [p.Amp, 0.0]
            @test p.A(100 * p.T) ≈ [-p.T * p.Amp, 0.0]
        end
        @testset "ConstantPulse" begin
            p = ConstantPulse()
            @test p.E(0.0) ≈ [p.Amp, 0.0]
            @test p.A(1.0) ≈ [-p.Amp, 0.0]
        end
        @testset "HarmonicPulse" begin
            p = HarmonicPulse()
            @test p.E(π / (2 * p.ω)) ≈ [p.Amp, 0.0]
            @test p.A(π / (2 * p.ω)) ≈ [p.Amp / p.ω, 0.0]
        end
    end
end

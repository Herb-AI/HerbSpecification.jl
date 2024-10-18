# Tests for IOExample
@testset "IOExample Tests" begin
    input_dict = Dict(:var1 => 42, :var2 => "value")
    output_value = "test output"
    io_example = IOExample(input_dict, output_value)

    @test io_example.in == input_dict
    @test io_example.out == output_value
end

# Tests for Problem
@testset "Problem Tests" begin
    # Example specs to use in the below tests.
    specs = [
         [
            IOExample(Dict(:var1 => 1, :var2 => 2), 3),
            IOExample(Dict(:var1 => 4, :var2 => 5), 6),
            IOExample(Dict(:var1 => 7, :var2 => 8), 9),
        ],
        AgdaSpecification(x -> 23),
        SMTSpecification(x -> 23),
        [Trace(["some", "exec", "path"]), Trace(["another", "path"])],
    ]

    @testset "$(typeof(spec))" for spec in specs
        # Test constructor without a name
        problem1 = Problem(spec)
        @test problem1.name == ""
        @test problem1.spec === spec

        # Test constructor with a name
        problem_name = "Test Problem"
        problem2 = Problem(problem_name, spec)
        @test problem2.name == problem_name
        @test problem2.spec === spec

        if spec isa Vector{<:IOExample}
            # Test getindex
            subproblem = problem2[1:2]
            @test isa(subproblem, Problem)
            @test subproblem.spec == spec[1:2]
            @test subproblem.name == ""
        end
    end
end

# Tests for MetricProblem
@testset "MetricProblem Tests" begin
    # Create a vector of IOExample instances as specification
    spec = [
        IOExample(Dict(:var1 => 1, :var2 => 2), 3),
        IOExample(Dict(:var1 => 4, :var2 => 5), 6),
        IOExample(Dict(:var1 => 7, :var2 => 8), 9),
    ]
    cost_function(x) = 23

    # Test constructor without a name
    metric1 = MetricProblem(cost_function, spec)
    @test metric1.name == ""
    @test metric1.spec === spec
    @test metric1.cost_function === cost_function

    # Test constructor with a name
    name = "Test Metric"
    metric2 = MetricProblem(name, cost_function, spec)
    @test metric2.name == name
    @test metric2.spec === spec
    @test metric2.cost_function === cost_function

    # Test getindex
    submetric = metric2[1:2]
    @test isa(submetric, Problem)
    @test submetric.spec == spec[1:2]
    @test submetric.name == ""
end

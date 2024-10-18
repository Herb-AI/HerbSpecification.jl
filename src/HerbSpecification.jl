module HerbSpecification

include("problem.jl")

export 
    Problem,
    MetricProblem,
    AbstractSpecification,

    IOExample,

    AbstractFormalSpecification,
    SMTSpecification,

    Trace,

    AbstractTypeSpecification,
    AbstractDependentTypeSpecification,
    AgdaSpecification

end # module HerbSpecification

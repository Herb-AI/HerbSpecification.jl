module HerbSpecification

include("problem.jl")

export 
    Problem,
    AbstractSpecification,

    AbstractIOSpecification,
    IOExample,
    IOSpecification,
    IOMetricSpecification,

    AbstractFormalSpecification,
    SMTSpecification,
    AgdaSpecification,

    Trace,
    TraceSpecification,

    TypeSpecification,
    DependentTypeSpecification

end # module HerbSpecification

abstract type AbstractSpecification end

"""
    struct Problem

Program synthesis problem defined with a vector of [`AbstractSpecification`](@ref)s. 

!!! warning
    Please care that concrete `Problem` types with different values of `T` are never subtypes of each other. 
"""
struct Problem{T <: AbstractSpecification}
    name::AbstractString
    spec::T

    function Problem(spec::T) where T<:AbstractSpecification
        new{T}("", spec)
    end
end


abstract type AbstractIOSpecification <: AbstractSpecification end

"""
    struct IOExample

An input-output example.
`in` is a [`Dict`](@ref) of `{Symbol,Any}` where the symbol represents a variable in a program.
`out` can be anything.
"""

struct IOExample
    in::Dict{Symbol, Any}
    out::Any
end

"""
    struct IOSpecification <: AbstractIOSpecification

"""
struct IOSpecification <: AbstractIOSpecification
    examples::Vector{IOExample}
end

"""
    struct IOMetricSpecification <: AbstractIOSpecification

"""
struct IOMetricSpecification <: AbstractIOSpecification
    examples::AbstractVector{IOExample}
    cost_function::Function
end

"""
    Base.getindex(p::Problem{AbstractIOSpecification}, indices)

Overwrite `Base.getindex` to access allow for slicing of problems.
"""
Base.getindex(p::Problem{AbstractIOSpecification}, indices) = Problem(p.spec.examples[indices])


abstract type AbstractFormalSpecification <: AbstractSpecification
end

"""
    struct SMTSpecification <: AbstractFormalSpecification

"""
struct SMTSpecification <: AbstractFormalSpecification
    formula::Function
end

"""
    struct AgdaSpecification <: AbstractFormalSpecification

"""
struct AgdaSpecification <: AbstractFormalSpecification
    formula::Function
end

# abstract type Trace end #@TODO combine with Gen.jl
struct Trace
    exec_path::Vector{Any}
end


"""
    struct TraceSpecification

"""
struct TraceSpecification <: AbstractSpecification
    traces::Vector{Trace}
end



abstract type AbstractTypeSpecification <: AbstractSpecification end

"""
    struct DependentTypeSpecification <: AbstractTypeSpecification

"""
struct DependentTypeSpecification <: AbstractTypeSpecification
    formula::Function
end

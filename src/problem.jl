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

# abstract type Trace end #@TODO combine with Gen.jl
struct Trace
    exec_path::Vector{Any}
end

abstract type AbstractFormalSpecification end

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


abstract type AbstractTypeSpecification end

"""
    struct DependentTypeSpecification <: AbstractTypeSpecification

"""
struct DependentTypeSpecification <: AbstractTypeSpecification
    formula::Function
end

const AbstractSpecification = Union{Vector{IOExample}, AbstractFormalSpecification, Vector{Trace}, AbstractTypeSpecification}

"""
    struct Problem

Program synthesis problem defined with a vector of [`AbstractSpecification`](@ref)s. 

!!! warning
    Please care that concrete `Problem` types with different values of `T` are never subtypes of each other. 
"""
struct Problem{T <: AbstractSpecification}
    name::AbstractString
    spec::T

    function Problem(spec::T) where T <: AbstractSpecification
        new{T}("", spec)
    end
    function Problem(name::AbstractString, spec::T) where T <: AbstractSpecification
        new{T}(name, spec)
    end
end


struct MetricProblem{T <: Vector{IOExample}}
    name::AbstractString
    cost_function::Function
    spec::T

    function MetricProblem(cost_function::Function, spec::T) where T<:Vector{IOExample}
        new{T}("", cost_function, spec)
    end

    function MetricProblem(name::AbstractString, cost_function::Function, spec::T) where T<:Vector{IOExample}
        new{T}(name, cost_function, spec)
    end

end


"""
    Base.getindex(p::Problem{Vector{IOExample}}, indices)

Overwrite `Base.getindex` to access allow for slicing of problems.
"""
Base.getindex(p::Problem{Vector{IOExample}}, indices) = Problem(p.spec[indices])
Base.getindex(p::MetricProblem{Vector{IOExample}}, indices) = Problem(p.spec[indices])



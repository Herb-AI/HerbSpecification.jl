using HerbSpecification
using Test


#=
Don't add your tests to runtests.jl. Instead, create files named

    test_title_for_my_test.jl

The file will be automatically included.
=#
@testset "HerbSpecification" verbose = true begin
    for (root, dirs, files) in walkdir(@__DIR__)
        for file in files
            if isnothing(match(r"^test_.*\.jl$", file))
                continue
            end
            include(file)
            # end
        end
    end
end

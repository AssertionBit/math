import Pkg;
Pkg.instantiate()
# Pkg.resolve()
# Pkg.precompile()

# using Meta

module utils 

function readarray() Array{Int8}
    expression = split(readline(), ",")
    vec::Vector{Int} = []
    for num in expression
        append!(vec, parse(Int, num))
    end
    return Array{Int8}(vec)
end

function readdict() Dict{Char, Int64}
    println("Enter Ctrl-D (EOF) when done.")
    keys = []
    values = []

    expression = readlines()

    for line in expression
        if isempty(line) || contains(line, '\0')
            break
        end

        string = split(line, "=")

        keys = append!(keys, String(string[1]))
        values = append!(values, parse(Int64, string[2]))
    end

    return Dict{Char, Int64}(zip(keys, values))
end

end # End of utils module

module vladimir

function argumentsPrinter(
    expression::String, 
    limits::Array{Int8}, 
    private_solution::Dict{Char, Int64},
) nothing
    println("Accepted these type of arguments:")
    println("\t Expression: ", expression)
    println("\t Limits: ", limits)
    println("\t Private soulutions: ", private_solution)
end

"""
Example:

    derivative("x^2")
    >>> String("2x")

-------------------------------------------------------------------------------

Take deravitive from the base expression and recive string. Expression exprects
    any kind of tokens from simple +-/* to (). Also You may use the expression
    to evaulate it just in time for result.
"""
function derivative(exp::String) String || nothing
    #TODO: make the algorithm
    return nothing
end

"""
Example:

    eulerUpdated("y'=x+y", Array([0, 1]), Dict("x" => 0, "y" => 0))

-------------------------------------------------------------------------------

Do the expression with extentended Euler method. Runs the expression through
    the default extended euler method and returns step-by-step solution of the
    task in array.

By default, prints all steps into stdout and does nothing to prevent error.
    If provided expression has error bounds, then will do nothing
"""
function eulerUpdated(
        expression::String,
        limits::Array{Int8},
        private_solution::Dict{Char, Int64},
    ) Int64
    
    argumentsPrinter(expression, limits, private_solution)

    h::Float64 = abs(limits[1]) + abs(limits[2]) / 10
    x0 = limits[1]
    y0 = 1

    function f(x, y)
        return Meta.parse("(x, y) =>" * expression, 1)
    end
    delta_y(Δy) = [xi + h/2, yi + (h/2) * f(x_i, y_i)]
    y_i(yi, Δy) = yi + delta_y(Δy)

    println("Using these parameters:")
    println("\th = ", h)
    println("\tx0 = ", x0)
    println("1. y0 = ", y0)
    
    println("# --------------- #");println("# Start executing #");println("# --------------- #")

    println(f(x0, y0))

    return 0
end

end # module vladimir

# Main function body
if isinteractive() 
    function main()
        println("Select method:")
        println("\t1. Extended Eurler method")
        println("\t...")
        selection::Int = parse(Int, readline())
        
        println("Insert data")
        print("Expression: "); expression::String = readline()
        print("Limits: "); limits::Array{Int8} = utils.readarray()
        println("Private solutions: "); private_solutions = utils.readdict()

        if selection == 1
            result = vladimir.eulerUpdated(
                expression,
                limits,
                private_solutions
                )
            
            println(result)
        else
            println("Non is selected")
        end
    end

    main()
end

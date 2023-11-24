using KineticEquation
using Documenter

DocMeta.setdocmeta!(KineticEquation, :DocTestSetup, :(using KineticEquation); recursive=true)

makedocs(;
    modules=[KineticEquation],
    authors="biplab37 <biplabmahato37@gmail.com> and contributors",
    repo="https://github.com/biplab37/KineticEquation.jl/blob/{commit}{path}#{line}",
    sitename="KineticEquation.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://biplab37.github.io/KineticEquation.jl",
        edit_link="main",
        assets=String[]
    ),
    pages=[
        "Home" => "index.md",
    ]
)

# deploydocs(;
#     repo="github.com/biplab37/KineticEquation.jl",
#     devbranch="main",
# )

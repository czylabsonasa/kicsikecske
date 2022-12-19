include("config.jl")

sample="""
"""


readit(input)=
  [cmd for cmd in split(input,"\n",keepempty=false)]


function part1(input)
  input=readit(input)
end


println("part1")
println("sample: ",part1(sample)) # 13140
println("input:  ",part1(read("input",String)))

include("config.jl")

sample="""
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"""

function part1(input)
  tot=0
  for row in split(input,"\n",keepempty=false)
    A,B,C,D=parse.(Int,map(x->isdigit(x) ? x : ' ',row)|>split)
    tot+=((A≤C && B≥D) || (C≤A && D≥B))
  end
  tot
end


println("part1")
println("sample: ",part1(sample))
println("input:  ",part1(read("input",String)))


function part2(input)
  tot=0
  input=split(input,"\n",keepempty=false)
  for row in input
    A,B,C,D=parse.(Int,map(x->isdigit(x) ? x : ' ',row)|>split)
    tot+=(B<C || D<A)
  end
  length(input)-tot
end


println("part2")
println("sample: ",part2(sample))
println("input:  ",part2(read("input",String)))

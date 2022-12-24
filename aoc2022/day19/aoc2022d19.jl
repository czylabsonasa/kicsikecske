include("config.jl")

sample="""
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian. 
"""


readit(input)=
  [cmd for cmd in split(input,"\n",keepempty=false)]


function part1(input)
  input=readit(input)
end


println("part1")
println("sample: ",part1(sample)) # 13140
println("input:  ",part1(read("input",String)))

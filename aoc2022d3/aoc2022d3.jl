##############################################################
#

##############################################################
# init env
include("config.jl")

##############################################################
# play

sample="""
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""


val(x)=x in 'a':'z' ? x-'a'+1 : x-'A'+27
function part1(input)
  tot=0
  for row in split(input,"\n",keepempty=false)
    L,R=row[1:end÷2],row[1+end÷2:end]
    tot+=sum(val.(intersect(L,R)))
  end
  tot
end


println("part1")
println("sample: ",part1(sample))
println("input : ",part1(read("input",String)))



function part2(input)
  tot=0
  input=split(input,"\n",keepempty=false)
  for n in 1:3:length(input)
    tot+=val.(intersect(input[n],input[n+1],input[n+2]))|>sum
  end
  tot
end


println("part2")
println("sample: ",part2(sample))
println("input : ",part2(read("input",String)))

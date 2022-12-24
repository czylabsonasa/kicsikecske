#!/home/nosy/bin/julia

cl_pars=length(ARGS)>0 ? ARGS : nothing

dbg=false

deps=[
  "DataStructures", # day11: Queue
  "Printf","PrettyTables" # 

]
include("config.jl")

include("util.jl")

for akt in cl_pars
  include("$(akt)/$(akt).jl")

  part1,part2,n_cases=eval(Meta.parse("$(akt)()"))

  (part1!==nothing) && mktable(akt,part1,n_cases,"part1")
  (part2!==nothing) && mktable(akt,part2,n_cases,"part2")
end

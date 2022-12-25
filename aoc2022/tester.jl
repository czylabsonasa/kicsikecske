#!/home/nosy/bin/julia
msg(x)=printstyled(x,color=:light_cyan)
function mktictoc()
  past=[]
  tic()=push!(past,time())
  toc()=past>[] ? time()-pop!(past) : 0.0
  tic,toc
end
tic,toc=mktictoc()


tic()
cl_pars=length(ARGS)>0 ? ARGS : nothing
dbg=false
deps=[
  "DataStructures", # day11: Queue
  "Printf","PrettyTables" # 

]
include("config.jl")
include("util.jl")

msg("Get up: $(round(toc(),digits=2)) sec\n")



for akt in cl_pars
  tic()
  include("$(akt)/$(akt).jl")
  part1,part2,n_cases=eval(Meta.parse("$(akt)()"))
  msg("Compile $(akt).jl: $(round(toc(),digits=2)) sec\n")

  tic()
  (part1!==nothing) && mktable(akt,part1,n_cases,"part1")
  (part2!==nothing) && mktable(akt,part2,n_cases,"part2")
  msg("Execute+prettytable: $(round(toc(),digits=2)) sec\n")
  
end


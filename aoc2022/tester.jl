#!/home/nosy/bin/julia
dbg=false

include("util.jl")

tic,toc=mktictoc()


tic()
cl_pars=length(ARGS)>0 ? ARGS : nothing
deps=[
  "DataStructures", # 11,12: Queue
  "Printf","PrettyTables" # 

]
include("config.jl")
include("lib.jl")

msg("getting up: $(round(toc(),digits=2)) sec\n")


for akt in cl_pars
  tic()
  include("$(akt)/$(akt).jl")
  part1,part2,cases=eval(Meta.parse("$(akt)()"))

  printstyled("\n"*"-o-"^15*"\n",color=40)
  msg(" include $(akt).jl: $(round(toc(),digits=2)) sec\n")
  printstyled("-o-"^15*"\n\n",color=40)

  for (part,part_name) in [(part1,"part1"),(part2,"part2")] 
    (part===nothing) && continue
    msg("  $(part_name)\n")
    what=(akt=akt,part=part,cases=cases,part_name=part_name)
    tic()
    res=runit(what)
    msg("   run:   $(round(toc(),digits=2))\n")

    tic()
    status=evalit(what,res)
    msg("   eval:  $(round(toc(),digits=2))\n")

    tic()
    printit(what,res,status)
    msg("   print: $(round(toc(),digits=2))\n\n")
  end
 
end


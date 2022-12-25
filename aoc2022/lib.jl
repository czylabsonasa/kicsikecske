using Printf: @sprintf
using PrettyTables

function runit(what)
  akt=what.akt
  part=what.part
  n_cases=what.n_cases
  
  res=[]
  tic,toc=mktictoc()
  for c in 1:n_cases
    case="$(c).in"

    tic()
    got=string(part("$(akt)/$(c).in"))
    elapsed=toc()

    push!(res,(case=case,got=got,elapsed=elapsed))
  end
  res
end

function evalit(what,res)
  n_cases=what.n_cases
  akt=what.akt
  part_name=what.part_name
  status=fill("",n_cases)
  for c in 1:n_cases
    if !isfile("$(akt)/$(part_name).$(c).out")
      status[c]="N/A"
      continue
    end
    expected=read("$(akt)/$(part_name).$(c).out",String)|>strip
    #printstyled("$(expected) vs $(res[c].got)\n" ,color=:red)
    if expected==res[c].got
      status[c]="OK"
    else
      status[c]="WA"
    end
  end
  status
end

function printit(what,res,status)
  h1 = Highlighter(f=(data, i, j)->(i==1),
                          crayon = crayon"yellow bold" )
  h2 = Highlighter(f=(data, i, j)->(i==2),
                          crayon = crayon"blue bold" )


  n_cases=what.n_cases
  akt=what.akt
  part_name=what.part_name

  # fake header (by hand)
  header=[
    "" akt part_name "";
    "case" "got" "status" "elapsed(sec)"
  ]
  data=fill("",n_cases,4)
  for c in 1:n_cases
    data[c,1]=res[c].case
    data[c,2]=res[c].got
    data[c,3]=status[c]
    data[c,4]=@sprintf "%.2e" res[c].elapsed
  end

  data=vcat(header,data)
  pretty_table(
    data;
    highlighters=(h1,h2),
    show_header=false,
    linebreaks=true,hlines=1:n_cases+size(header,1)
  )
end

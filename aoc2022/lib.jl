using Printf: @sprintf
using PrettyTables

function runit(what)
  akt=what.akt
  part=what.part
  cases=what.cases
  
  res=[]
  tic,toc=mktictoc()
  for c in cases
    case="$(c).in"

    tic()
    got=string(part("$(akt)/$(c).in"))
    elapsed=toc()

    push!(res,(case=case,got=got,elapsed=elapsed))
  end
  res
end

function evalit(what,res)
  cases=what.cases
  akt=what.akt
  part_name=what.part_name
  status=fill("",length(cases))
  for (i,c) in enumerate(cases)
    if !isfile("$(akt)/$(part_name).$(c).out")
      status[i]="N/A"
      continue
    end
    expected=read("$(akt)/$(part_name).$(c).out",String)|>strip
    #printstyled("$(expected) vs $(res[c].got)\n" ,color=:red)
    if expected==res[i].got
      status[i]="OK"
    else
      status[i]="WA"
    end
  end
  status
end

function printit(what,res,status)
  h1 = Highlighter(f=(data, i, j)->(i==1),
                          crayon = crayon"yellow bold" )
  h2 = Highlighter(f=(data, i, j)->(i==2),
                          crayon = crayon"blue bold" )


  h3crayon(data,i,j)=if x=="OK"
      crayon"green"
    elseif x=="WA"
      crayon"red"
    else
      crayon"yellow"
    end

  # is it possible to Highlight by content?
  # a very ugly approach:
  hOK = Highlighter(f=(data, i, j)->(i>2) && (j==3) && data[i,j]=="OK",
                          crayon = crayon"green" )

  hWA = Highlighter(f=(data, i, j)->(i>2) && (j==3) && data[i,j]=="WA",
                          crayon = crayon"red" )

  hNA = Highlighter(f=(data, i, j)->(i>2) && (j==3) && data[i,j]=="N/A",
                          crayon = crayon"yellow" )


  cases=what.cases
  akt=what.akt
  part_name=what.part_name

  # fake header (by hand)
  header=[
    "" akt part_name "";
    "case" "got" "status" "elapsed(sec)"
  ]
  data=fill("",length(cases),4)
  for i in 1:length(cases)
    data[i,1]=res[i].case
    data[i,2]=res[i].got
    data[i,3]=status[i]
    data[i,4]=@sprintf "%.2e" res[i].elapsed
  end

  data=vcat(header,data)
  pretty_table(
    data;
    highlighters=(h1,h2,hOK,hWA,hNA),
    show_header=false,
    linebreaks=true,hlines=1:length(cases)+size(header,1)
  )
end

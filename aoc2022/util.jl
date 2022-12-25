using Printf: @sprintf
using PrettyTables


function mktable(akt,part,n_cases,part_name)
  h1 = Highlighter(f=(data, i, j)->(i==1),
                          crayon = crayon"yellow bold" )
  h2 = Highlighter(f=(data, i, j)->(i==2),
                          crayon = crayon"blue bold" )
  header=[
    "" akt part_name "";
    "case" "got" "expected" "elapsed(sec)"
  ]
  res=fill("",n_cases,4)
  for c in 1:n_cases
    res[c,1]="$(c).in"
    et=time()
    ans=part("$(akt)/$(c).in")
    et=time()-et

    res[c,2]=string(ans)
    res[c,3]=if isfile("$(akt)/$(part_name).$(c).out")
      read("$(akt)/$(part_name).$(c).out",String)
    else
      "?"
    end
    res[c,4]=@sprintf "%.2e" et
  end
  res=vcat(header,res)
  pretty_table(
    res;
    highlighters=(h1,h2),
    show_header=false,
    linebreaks=true,hlines=1:n_cases+size(header,1)
  )
end

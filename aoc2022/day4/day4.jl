function day4()

  readit(input)=split(read(input,String),"\n",keepempty=false)

  function part1(input)
    input=readit(input)
    tot=0
    for row in input
      A,B,C,D=parse.(Int,map(x->isdigit(x) ? x : ' ',row)|>split)
      tot+=((A≤C && B≥D) || (C≤A && D≥B))
    end
    tot
  end


  function part2(input)
    input=readit(input)
    tot=0
    for row in input
      A,B,C,D=parse.(Int,map(x->isdigit(x) ? x : ' ',row)|>split)
      tot+=(B<C || D<A)
    end
    length(input)-tot
  end

  part1,part2,2

end # of day4 

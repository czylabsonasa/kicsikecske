function day3()


  readit(input)=split(read(input,String),"\n",keepempty=false)

  val(x)=x in 'a':'z' ? x-'a'+1 : x-'A'+27
  function part1(input)
    input=readit(input)
    tot=0
    for row in input
      L,R=row[1:end÷2],row[1+end÷2:end]
      tot+=sum(val.(intersect(L,R)))
    end
    tot
  end


  function part2(input)
    input=readit(input)
    tot=0
    for n in 1:3:length(input)
      tot+=val.(intersect(input[n],input[n+1],input[n+2]))|>sum
    end
    tot
  end

  part1,part2,2

end # of day3()

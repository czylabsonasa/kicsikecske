##############################################################
# advent of code 2022 day 1

function day1()

  readit(fname)=split(read(fname,String),keepempty=true)

  function part1(input)
    input=readit(input)
    maxi=akt=0 
    for v in input
      if v>"" 
        v=parse(Int,v) 
      else 
        maxi=max(maxi,akt)
        akt=v=0
      end
      akt+=v
    end
    maxi
  end


  function part2(input)
    input=readit(input)
    cals=[]
    akt=0
    for v in input
      if v>"" 
        akt+=parse(Int,v) 
      else 
        akt>0 && push!(cals,akt)
        akt=0
      end
    end
    sum(sort(cals)[end-2:end])
  end

  (part1,part2,2)

end # of day1()

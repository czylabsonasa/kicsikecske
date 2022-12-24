##############################################################
# aoc2022 day 2


function day2()

  readit(input)=[split(row) for row in split(read(input,String),"\n",keepempty=false)]


  #         Sc      P      R
  pt=Dict("C"=>3,"B"=>2,"A"=>1)
  lose=Dict("B"=>"C","A"=>"B","C"=>"A")
  tr=Dict("Z"=>"C","Y"=>"B","X"=>"A")

  function part1(input)
    input=readit(input)
    # apply
    totpt=0
    for (k,v) in input
      v=tr[v]
      if v==k
        totpt+=3
      elseif v==lose[k]
        totpt+=6
      end
      totpt+=pt[v]
    end
    totpt
  end


  win=Dict("C"=>"B","B"=>"A","A"=>"C")
  function part2(input)
    input=readit(input)
    # apply
    totpt=0
    for (k,v) in input
      if v=="X"        # lose
        v=win[k]
      elseif v=="Y"    # draw
        totpt+=3
        v=k
      else             # win
        totpt+=6
        v=lose[k]
      end              
      totpt+=pt[v]
    end
    totpt
  end

  part1,part2,2
  
end # of day2()

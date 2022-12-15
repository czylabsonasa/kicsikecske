##############################################################
# aoc2022 day 2

##############################################################
# init env

using Pkg
Pkg.activate(".")
Pkg.instantiate()

deps=[]

for p in deps
  Pkg.add(p)
end


if deps>[]
  useit="using "*join(deps,",")
  Meta.parse(useit)|>eval
end


##############################################################
# play

# pairs

sample="""
A Y
B X
C Z
"""
#         Sc      P      R
pt=Dict("C"=>3,"B"=>2,"A"=>1)
lose=Dict("B"=>"C","A"=>"B","C"=>"A")
tr=Dict("Z"=>"C","Y"=>"B","X"=>"A")

function part1(input)
  input=[split(row) for row in split(input,"\n",keepempty=false)]
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


println("part1")
println("sample: ", part1(sample))
println("input : ", part1(read("input",String)))


win=Dict("C"=>"B","B"=>"A","A"=>"C")
function part2(input)
  input=[split(row) for row in split(input,"\n",keepempty=false)]
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

println("part2")
println("sample: ", part2(sample))
println("input : ", part2(read("input",String)))

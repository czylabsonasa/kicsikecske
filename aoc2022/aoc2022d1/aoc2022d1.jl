##############################################################
# advent of code 2022 day 1


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


input="""
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000"""


function part1(input)
  maxi=akt=0 
  for v in split(input,keepempty=true)
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

println("part1")
println("sample: ",string(part1(input)))
println("file  : ",part1(read("input",String)))

function part2(input)
  cals=[]
  akt=0
  for v in [split(input,keepempty=true)...,""]
    if v>"" 
      akt+=parse(Int,v) 
    else 
      akt>0 && push!(cals,akt)
      akt=0
    end
  end
  sum(sort(cals)[end-2:end])
end


println("part2")
println("sample: ",string(part2(input)))
println("file  : ",part2(read("input",String)))

include("config.jl")

sample="""
2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5
"""


readit(input)=
  [cmd for cmd in split(input,"\n",keepempty=false)]


function part1(input)
  input=readit(input)
  van=Set{Tuple{Int,Int,Int}}()
  for line in input
    a,b,c=parse.(Int,split(line,','))
    push!(van,(a,b,c))
  end
  edges=0
  for (a,b,c) in van
    edges+=(
      ((a,b,c+1) in van)+
      ((a,b,c-1) in van)+
      ((a,b+1,c) in van)+
      ((a,b-1,c) in van)+
      ((a+1,b,c) in van)+
      ((a-1,b,c) in van)
    )
  end
  # edges counted 2x and 1 edge "removes" two faces
  # so leave it as is
  6*length(van)-edges 
end


println("part1")
println("sample: ",part1(sample)) # 13140
println("input:  ",part1(read("input",String)))

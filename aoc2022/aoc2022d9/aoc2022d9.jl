include("config.jl")

sample="""
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
"""

readit(input)=
  [(r=split(row);(r[1],parse(Int,r[2]))) 
    for row in split(input,"\n",keepempty=false)]


function part1(input)
  input=readit(input)

  dirs=Dict(
    "D"=>(1,0),
    "U"=>(-1,0),
    "L"=>(0,-1),
    "R"=>(0,1)
  )
  
  vis=Set{Tuple{Int,Int}}()
  H,T=(0,0),(0,0)
  push!(vis,T)
  for (s,n) in input
    for _ in 1:n
      H=H.+dirs[s]
      δ=(H.-T)
      if maximum(abs.(δ))>1
        T=T.+sign.(δ)
        push!(vis,T)
      end
      #println(H," ",T," ",δ)
    end
  end
  length(vis)
end


println("part1")
println("sample: ",part1(sample))
println("input:  ",part1(read("input",String)))


function part2(input)
  input=readit(input)

  dirs=Dict(
    "D"=>(1,0),
    "U"=>(-1,0),
    "L"=>(0,-1),
    "R"=>(0,1)
  )
  
  vis=Set{Tuple{Int,Int}}()
  HT=fill((0,0),10)
  push!(vis,(0,0))
  for (s,n) in input
    for _ in 1:n
      HT[1]=HT[1].+dirs[s]
      i=1
      while i<10
        δ=(HT[i].-HT[i+1])
        maxδ=maximum(abs.(δ))
        (maxδ<2) && break
        HT[i+1]=HT[i+1].+sign.(δ)
        i+=1
      end
      (i==10) && push!(vis,HT[10])
      #println(H," ",T," ",δ)
    end
  end
  length(vis)
end


sample2="""
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
"""


println("part2")
println("sample: ",part2(sample))
println("sample: ",part2(sample2))
println("input:  ",part2(read("input",String)))





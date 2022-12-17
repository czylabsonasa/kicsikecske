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

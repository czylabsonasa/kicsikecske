function day9()

  readit(input)=
    [(r=split(row);(r[1],parse(Int,r[2]))) 
      for row in split(read(input,String),"\n",keepempty=false)]


  dirs=Dict(
    "D"=>(1,0),
    "U"=>(-1,0),
    "L"=>(0,-1),
    "R"=>(0,1)
  )


  function part1(input)
    input=readit(input)

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
  end # of part1


  function part2(input)
    input=readit(input)

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
  end # of part2


  part1, part2, 3

end # of day9





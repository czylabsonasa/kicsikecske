function day5()

  function readit(input)
    input=split(read(input,String),"\n",keepempty=false)
    nst=0
    st=Vector{Char}[]

    r=1
    while true
      !occursin('[',input[r]) && break
      if r==1
        nst=length(input[1][2:4:end]) # ad hoc, by inspecting
        st=[Char[] for _ in 1:nst]
      end
      for (i,c) in enumerate(input[r][2:4:end])
        (c==' ') && continue
        push!(st[i],c)
      end
      r+=1
    end

    #println(st)

    @assert length(split(input[r]))==nst # no check for 1:nst

    r+=1 
    ops=Tuple{Int,Int,Int}[]
    while r<=length(input)
      a,b,c=parse.(Int,map(x->isdigit(x) ? x : ' ',input[r])|>split)
      #println(a,b,c)    
      push!(ops,(a,b,c))
      r+=1
    end

    st,ops
  end # of readit()

  # splice
  # https://stackoverflow.com/questions/68997862/pop-multiple-items-from-julia-vector

  function part1(input)
    st,ops=readit(input)
    for i in eachindex(st)
      reverse!(st[i])
    end
    for (a,b,c) in ops # move a from b to c
      #println(st)
      append!(st[c],
        splice!(st[b],(n=length(st[b]);n-a+1:n))|>reverse!
      )
    end  
    

    join(sti[end] for sti in st if sti>[]) # assume that each of them is non-empty

  end # of part1()




  function part2(input)
    st,ops=readit(input)
    for i in eachindex(st)
      reverse!(st[i])
    end
    for (a,b,c) in ops # move a from b to c
      #println(st)
      append!(st[c],
        splice!(st[b],(n=length(st[b]);n-a+1:n)) # removing reverse! is the only diff
      )
    end  
    

    join(sti[end] for sti in st if sti>[]) # assume that each of them is non-empty
  end # of part2()
  

  part1,part2,2

  
end # of day5()


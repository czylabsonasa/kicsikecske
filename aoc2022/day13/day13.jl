# dispatch

function day13()
    
  Cmp(x::Int,y::Int)=cmp(x,y)

  # Cmp(x::Int,y::Vector{Int})=cmp([x],y)
  # Cmp(x::Vector{Int},y::Int)=cmp(x,[y])
  # Cmp(x::Vector{Int},y::Vector{Int})=cmp(x,y)
  

  function Cmp(x::Int,y)
    isempty(y) && (return 1)
    Cmp([x],y)
  end
  function Cmp(x,y::Int)
    isempty(x) && (return -1)
    Cmp(x,[y])
  end


  function Cmp(x,y)
    lx,ly=length(x),length(y)
    (lx==0 || ly==0) && (return sign(lx-ly))

    c=nothing
    k=1
    @inbounds while k≤min(lx,ly)
      c=Cmp(x[k],y[k])
      (c!=0) && break
      k+=1
    end
    if c==0
      c=sign(lx-ly)
    end
    c
  end

  readit(input)=(
    input=split(read(input,String),"\n",keepempty=false);
    [Meta.eval(Meta.parse(input[i])) for i in 1:length(input)]
  )
    

  function part1(input)
    input=readit(input)
    lt=0
    for i in 1:2:length(input)-1
      if Cmp(input[i],input[i+1])==-1
        lt+=(i+1)÷2
      end
    end
    lt
  end # of part1

  function part2(input)
    input=readit(input)
    input=[input...,[[2]],[[6]]]
    sort!(input,lt=(x,y)->Cmp(x,y)==-1)
    i=findfirst(==([[2]]),input)
    j=findfirst(==([[6]]),input)
    i*j
  end # of part2

  part1,part2,[1,2]

end # day13


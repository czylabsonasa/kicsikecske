using DataStructures: Queue, enqueue!, dequeue!


function day12()

  # as in day8
  readit(input)=mapreduce(
    permutedims,
    vcat,
    split(read(input,String),"\n",keepempty=false).|>collect
  ) 


  function part1(input)
    table=readit(input)
    
    R,C=size(table)
    INF=R*C+1
    dist=fill(INF,R,C)
    S=Tuple(findfirst(==('S'),table))
    E=Tuple(findfirst(==('E'),table))
    table[S...]='a'
    table[E...]='z'
    dist[S...]=0

    Q=Queue{Tuple{Int,Int}}()
    enqueue!(Q,S)
    while length(Q)>0
      s=dequeue!(Q)
      (s==E) && break
      sx,sy=s
      d=dist[sx,sy]+1
      c=table[sx,sy]
      for (tx,ty) in [(sx-1,sy),(sx+1,sy),(sx,sy-1),(sx,sy+1)]
        (tx<1 || tx>R || ty<1 || ty>C || table[tx,ty]-c>1 || d>=dist[tx,ty]) && continue
        dist[tx,ty]=d
        enqueue!(Q,(tx,ty))
      end
    end

    dist[E...]
  end

  part1,nothing,2
end

include("config.jl")


readit(input)=
  [cmd for cmd in split(input,"\n",keepempty=false)]


function part1(input)
  input=readit(input)
  N=length(input)  

  obs_c=20
  obs_X=[]

  shift_mod(arr,m)=(arr[1]=arr[2];arr[2]=arr[3];arr[3]+=m)

  X=[1,1,1]
  c=[0,0,0]
  for cmd in input
    cmd=split(cmd)
    #println(stderr,cmd, " ", c[2], " ",X)
    if length(cmd)==1
      shift_mod(c,1)
      shift_mod(X,0)
    else
      shift_mod(c,2)
      #addx=parse(Int,cmd[2])
      #println(stderr,addx)
      shift_mod(X,parse(Int,cmd[2]))
    end

    if c[3]>obs_c            
      if c[2]==obs_c
        push!(obs_X,X[1]*obs_c)
      else
        push!(obs_X,X[2]*obs_c)
      end
      obs_c+=40
    end

    (obs_c>220) && break
  end
  println(stderr,join(obs_X," "))
  sum(obs_X)
  
end


println("part1")
println("sample: ",part1(read("sample",String))) # 13140
println("input:  ",part1(read("input",String)))



# the value of X is needed during each cycle
function part2(input,L=40,nL=6)
  input=readit(input)

  i=0      # for access the input
  X=1      # aktual val
  state=1
  dX=0

  # two loops -> no modulo (but higher code complexity)
  disp=[]
  for cc in 1:(L*nL) # can be 0 based (cc-1 <-> cc)
    state-=1
    if state==0
      X+=dX
      cmd=split(input[i+=1]) 
      if length(cmd)==1
        state=1
        dX=0
      else
        state=2
        dX=parse(Int,cmd[2])
      end
    end
    # println(stderr,X)
    push!(disp,abs((cc-1)%L-X)<2 ? '#' : '.')
    
  end
  reshape(disp,L,nL)|>permutedims|>eachrow.|>join|>x->join(x,"\n")
end


println("part2")
println("sample:\n",part2(read("sample",String))) # 13140
println("input: \n",part2(read("input",String)))


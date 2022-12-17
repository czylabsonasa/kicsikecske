include("config.jl")

sample="""
30373
25512
65332
33549
35390
"""

readit(input)=mapreduce(
  permutedims,
  vcat,
  split(input,"\n",keepempty=false).|>collect.|>x->parse.(Int,x)
) 
function part1(input)
  A=readit(input)
  #println(A)
  ret=fill(false,size(A))
  for _ in 1:4
    r,c=size(A)
    tmp=fill(-1,c)
    for k in 1:r
      ret[k,:]=ret[k,:].||(A[k,:].>tmp)
      tmp=max.(tmp,A[k,:])
    end
    A=rotl90(A)
    ret=rotl90(ret)
  end
  #println(A)
  #println(ret)
  sum(ret)
end

println("part1")
println("sample: ",part1(sample))
println("input:  ",part1(read("input",String)))



# similar approach (rotl90), but here a monotone stack is used to 
# administer the closest larger to the left

function part2(input)
  A=readit(input)
  #display(A)
  INF=10
  ret=fill(1,size(A))
  for _ in 1:4
    r,c=size(A)
    for i in 1:r
      sta=[(INF,-1)] # negate to handle ties correctly
      for j in 1:c
        v=(A[i,j],-j)
        while v>sta[end]
          pop!(sta)
        end
        ret[i,j]*=(j+sta[end][2])
        push!(sta,v)
      end        
    end
    A=rotl90(A)
    ret=rotl90(ret)
  end
  #println(A)
  #display(ret)
  maximum(ret[:])
end

println("part2")
println("sample: ",part2(sample))
println("input:  ",part2(read("input",String)))


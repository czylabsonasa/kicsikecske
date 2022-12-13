##############################################################
# https://discourse.julialang.org/t/count-occurances-for-matrix-rows-where-column-order-does-not-matter/91374


##############################################################
# init env

using Pkg
pkg"activate ."
pkg"instantiate"
#Pkg.activate(".")
using StaticArrays, BenchmarkTools, StatsBase, PrettyTables, Printf


##############################################################
# data generator by OP

function generateF(;r=1.0,s=0.01)
  function grid3D(x,y,z)
    X = [ i for i ∈ x          , j ∈ 1:length(y), k ∈ 1:length(z) ]
    Y = [ j for i ∈ 1:length(x), j ∈ y          , k ∈ 1:length(z) ]
    Z = [ k for i ∈ 1:length(x), j ∈ 1:length(y), k ∈ z           ]
    X, Y, Z
  end

  X,Y,Z= grid3D(-r:s:r,-r:s:r,-r:s:r)

  M = sqrt.(X.^2 .+ Y.^2 .+ Z.^2)

  siz=size(M)
  #println(siz)
  sizV=siz.+1
  function getElements(ijk)
      
    #Cartesian index offsets
    iStep = CartesianIndex(1,0,0)
    jStep = CartesianIndex(0,1,0)
    kStep = CartesianIndex(0,0,1)

    F=zeros(Int64,6*length(ijk),4)
    for q=1:1:length(ijk)
      #Build 8-noded hex element
      e=[
        LinearIndices(sizV)[ijk[q]] 
        LinearIndices(sizV)[ijk[q]+iStep] 
        LinearIndices(sizV)[ijk[q]+iStep+jStep] 
        LinearIndices(sizV)[ijk[q]+jStep]
        LinearIndices(sizV)[ijk[q]+kStep]
        LinearIndices(sizV)[ijk[q]+iStep+kStep]
        LinearIndices(sizV)[ijk[q]+iStep+jStep+kStep]
        LinearIndices(sizV)[ijk[q]+jStep+kStep]
      ]

      F[1+(q-1)*6:q*6,:]=[
        e[[4 3 2 1]];
        e[[5 6 7 8]]; 
        e[[1 2 6 5]];
        e[[2 3 7 6]];
        e[[3 4 8 7]];
        e[[4 1 5 8]];
      ]
    end

    F
  end


  L=M.<=(r+s/100) #Bool defining segmentation
  ijk=findall(L) #Cartesian indices
  getElements(ijk)
end


##############################################################
# transforms F into an SVector and sort (the rows of) F at once

function trans(F)
  sort.(SVector{4,Int}.(eachrow(F)))
end


##############################################################
# functions to test

funstore=Dict{String,Function}()

function onlyonce1(F) 
  n=length(F)
  L=zeros(Bool,n)
  # Loop over faces 
  # i got misbehaving syntax highlighting w/ comments
  # in the end of line
  for q=1:n 
    L[q]=count(==(F[q]),F)==1
  end
  (1:n)[L]
end
funstore["O(n^2)"]=onlyonce1


function onlyoncex(F)
  cm = countmap(F)
  (1:length(F))[[ifelse(cm[v]==1,true,false) for v in F]]
end
funstore["countmap by @dan"]=onlyoncex

function onlyonce3(F)
  d = Dict{eltype(F),Int}()
  del = Dict{eltype(F),Int}()
  for i in eachindex(F)
    if haskey(d, F[i]) & ~haskey(del, F[i])
      delete!(d, F[i]) #Remove from d             
      del[F[i]] = i #Add to deleted
    else
      d[F[i]] = i
    end
  end
  sort(collect(values(d)))
end
funstore["2 dicts by @halleysfifthinc+OP"]=onlyonce3


function onlyonce6(F)
  cand = Dict{eltype(F),Int}()
  for i in eachindex(F)
    v=F[i]
    j=get(cand,v,0)
    if j==0
      cand[v]=i
    elseif j>0
      cand[v]=-1
    end
  end
  sort([i for i in values(cand) if i>0])
end
funstore["1 dict"]=onlyonce6

function onlyonce7(F)
  n=length(F)
  p,len=nothing,nothing
  ret=fill(false,n)
  for (v,i) in sort([(F[i],i) for i in 1:n])
    if v==p
      len+=1
    else
      (len==1) && (ret[i]=true)
      p,len=v,1
    end
  end
  (1:n)[ret]
end
funstore["sort"]=onlyonce7




##############################################################
# small test
let
#r(x)=round(x,digits=2)|>string
header=["fun","time(s)","mem(MB)","allocs(#)"]
table=[]
F=trans(generateF(r=1.0,s=0.1))
println("size of F: $(length(F))")
out=nothing
for (funname,fun) in funstore
  contains(funname,"O(n^2)") && continue
  aktout=nothing
  akt=median(@benchmark aktout=($fun)($F));
  if out===nothing
    out=aktout
  else
    @assert out==aktout, fname
  end
  push!(table,[
    funname, 
    (@sprintf "%.2e" akt.time/10^9), 
    (@sprintf "%.2e" akt.memory/1024^2), 
    string(akt.allocs)
  ])
end  

table=permutedims(hcat(table...),(2,1))
pretty_table(table,header=header)
end

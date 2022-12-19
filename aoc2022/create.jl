#!/home/nosy/bin/julia

if length(ARGS)!=1
  println("i need 1(one) number (not a hero)...")
  exit(1)
end

d=try
  parse(Int,ARGS[1])
catch
  println("a number please...")
  exit(2)
end

try
  @assert 1≤d≤25
catch
  println("a number between 1 and 25, please...")
  exit(3)
end

target="aoc2022d$(d)"
try
  mkdir(target)
catch
  println("already exists...")
  exit(4)
end

cp("../config.jl","$(target)/config.jl")
cp("temp.jl","$(target)/$(target).jl")

println(stderr,"OK!")







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
if !isdir(target)
  mkdir(target)
end


if !isfile("$(target)/config.jl")
  #cp("config.jl","$(target)/config.jl")
  cd("$(target)")
  symlink("../config.jl","config.jl")
  cd("..")
end

if !isfile("$(target)/$(target).jl")
  cp("temp.jl","$(target)/$(target).jl")
end

println(stderr,"OK!")

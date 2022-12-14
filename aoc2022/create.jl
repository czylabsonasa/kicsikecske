#!/home/nosy/bin/julia

if length(ARGS)!=1
  println("i need a number (not a hero)...")
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

target="day$(d)"
if !isdir(target)
  mkdir(target)
end


if !isfile("$(target)/$(target).jl")
  temp=replace(read("temp.jl",String),
    "__DAY__"=>target)
  open("$(target)/$(target).jl","w") do f
    write(f,temp)
  end
end

touch(f)=if !isfile(f)
  open(f,"w") do fh
    nothing
  end
end


for f in 1:2
  touch("$(target)/$(f).in")
  touch("$(target)/part1.$(f).out")
  touch("$(target)/part2.$(f).out")
end

println(stderr,"OK!")

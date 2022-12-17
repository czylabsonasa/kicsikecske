include("config.jl")

sample="""
mjqjpqmgbljsphdztnvjfqwrcgsmlb
bvwbjplbgvbhsrlpgdmjqwftvncz
nppdvjthqldpwncqszvftbrmjlhg
nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg
zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw
"""

function part1(input,L=4)
  volt=fill(0,26)
  for c in input[1:L]
    volt[c-'a'+1]+=1
  end
  nbad=count(>(1),volt)

  i=L
  while nbad>0
    i+=1
    cbe=input[i]-'a'+1
    cki=input[i-L]-'a'+1
    nbad+=(volt[cbe]==1)
    volt[cbe]+=1
    nbad-=(volt[cki]==2)
    volt[cki]-=1
  end
  i
end


println("part1")
println("sample:")
for row in split(sample,"\n",keepempty=false)
  println(part1(row))
end
println("input:  ",part1(read("input",String)))



part2(x)=part1(x,14)

println("part2")
println("sample:")
for row in split(sample,"\n",keepempty=false)
  println(part2(row))
end
println("input:  ",part2(read("input",String)))


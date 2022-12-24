function day6()

  readit(input)=readline(input)
  

  function part1(input,L=4)
    input=readit(input)
    
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

  part2(x)=part1(x,14)

  part1,part2,6
end

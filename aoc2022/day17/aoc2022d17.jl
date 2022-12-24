# just trying out CircularArrays
deps=["CircularArrays"]
include("config.jl")


sample=">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"


function part1(input,N=2022,VGAP=3,HGAP=2)
  moves=CircularArray(
    [v=='<' ? -1 : 1 for v in input]
  )

  rch=1; ch=permutedims(fill(1,9))
  rEXT=100; EXT=fill(1,rEXT,9);EXT[1:rEXT,2:8].=0

  extend()=(ch=vcat(ch,EXT);rch+=rEXT)
  extend()

  # vertically reversed shapes
  figs=CircularArray([
    ([1 1 1 1],(1,4)),
    ([0 1 0;1 1 1;0 1 0],(3,3)),
    ([1 1 1;0 0 1;0 0 1],(3,3)),
    ([1;1;1;1],(4,1)),
    ([1 1;1 1],(2,2))
  ])

  chview(loc,rfig,cfig)=
    @view ch[loc[1]:(loc[1]+rfig-1),loc[2]:(loc[2]+cfig-1)]
  

  m=0 # index for figs and moves
  top=1   # topmost occupied row
  for n in 1:N
    fig,(rfig,cfig)=figs[n]
    # println(stderr,n)
    # println(stderr,(rfig,cfig))
    
    if top+VGAP+rfig+7>rch
      extend()
    end
    loc=(top+VGAP+1,1+HGAP+1) # by definition
    while true
      tloc=(loc[1],loc[2]+moves[m+=1])
      #println(loc," ",moves[m])
      if sum(chview(tloc,rfig,cfig).*fig)==0
        loc=tloc
      end
      #println(loc)
      tloc=(loc[1]-1,loc[2])
      if sum(chview(tloc,rfig,cfig).*fig)!=0
        break
      end
      loc=tloc
    end
    #println("*$(loc)")
    #chview(loc,rfig,cfig).=fig # it is wrong (not 4 the sample!)
    
    chview(loc,rfig,cfig).+=fig
    top=max(top,loc[1]+rfig-1)
    # if true
      # display(fig[end:-1:1,:])
      # for r in eachrow(ch[top+1:-1:1,:])
        # println(replace(join(r),'0'=>'.','1'=>'#'))
      # end
    # end
  end
  #println(m)
  top-1
end


println("part1")
println("sample: ",part1(sample))
println("input:  ",part1(readline("input")))

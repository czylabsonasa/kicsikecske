deps=[]
include("../config.jl")

module aoc2022d7

export 
   process, trav, Node

struct Node1
  name::AbstractString
  tip::Symbol
  content::Union{AbstractString,Dict{AbstractString,Node1}}
end
Node=Node1 


dir_content=Dict{AbstractString,Node}
newdir(name,content)=Node(name,:dir,content)
newfile(name,content)=Node(name,:file,content)
newroot(name)=(
  root=newdir(name,dir_content());
  root.content[".."]=root;
  root
)


function insert(x,name,tip,content="")
  if !haskey(x.content,name)
    x.content[name]=if tip===:file
      newfile(name,content)
    else 
      newdir(name,dir_content(".."=>x))
    end
  end
end


function process(sample)
  root=newroot("/")
  akt=root
  for line in split(sample,"\n",keepempty=false).|>strip
    line=split(line)
    if line[1]=="\$"
      if line[2]=="ls"
        nothing # pushing everything that follows into 'akt'
      else # cd
        if line[3]=="/"
          akt=root
        else
          akt=akt.content[line[3]]
        end
      end
    elseif line[1]=="dir"
      insert(akt,line[2],:dir)
    else  # file
      insert(akt,line[2],:file,line[1])
    end
  end
  root
end

function trav(akt,dsizes,indent="",prt=false)
  (prt==true) && println(stderr,"$(indent)$(akt.name)")
  if akt.tip===:file
    return parse(Int,akt.content)
  end

  s=0
  for (name,node) in akt.content
    (name=="..") && continue
    s+=trav(node,dsizes,indent*" ")
  end
  dsizes[akt]=s
  s
end

end # module


################################################

using .aoc2022d7

sample=raw"""
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
"""

function part1(input)
  root=process(input)
  dsizes=Dict{Node,Int}()
  trav(root,dsizes)
  L=100000
  sum(s for (_,s) in dsizes if s<=L)
end

function part2(input)
  root=process(input)
  dsizes=Dict{Node,Int}()
  # both part can be solved trav once
  trav(root,dsizes)

  dsizes=sort([s for (_,s) in dsizes])
  
  SPACE=70000000
  UNUSED=SPACE-dsizes[end]
  REQ=30000000
  opt=-1
  for s in dsizes
    if UNUSED+s>=REQ
      opt=s
      break 
    end
  end
  opt
end



println("part1")
println("sample: ",part1(sample)) # 95437
println("input:  ",part1(read("input",String))) # 1644735

println("part2")
println("sample: ",part2(sample))
println("input:  ",part2(read("input",String)))

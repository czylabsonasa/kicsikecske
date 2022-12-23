##############################################################
# init env

using Pkg
Pkg.activate(".")
Pkg.instantiate()

deps=[]

for p in deps
  Pkg.add(p)
end


if deps>[]
  useit="using "*join(deps,",")
  Meta.parse(useit)|>eval
end


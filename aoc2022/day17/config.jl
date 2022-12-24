##############################################################
# init env

using Pkg
Pkg.activate(".")
Pkg.instantiate()

if isdefined(Main,:deps) && deps>[]
  for p in deps
    Pkg.add(p)
  end

  useit="using "*join(deps,",")
  Meta.parse(useit)|>eval
end

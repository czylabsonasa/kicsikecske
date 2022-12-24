##############################################################
# init env

import Pkg
Pkg.activate(".")

if cl_pars===nothing && isdefined(Main,:deps) && deps>[]
  Pkg.instantiate()
  Pkg.add.(deps)
  exit(1)
end


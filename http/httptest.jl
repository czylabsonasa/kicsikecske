##############################################################
# http realated stuff from Adrian Salceanu julia projects book


##############################################################
# init env

using Pkg
Pkg.activate(".")
Pkg.instantiate()

deps=["HTTP",]


for p in deps
  Pkg.add(p)
end


useit="using "*join(deps,",")
Meta.parse(useit)|>eval


##############################################################
# play


resp=HTTP.get("https://en.wikipedia.org/wiki/Julia_(programming_language)");
fieldnames(typeof(resp))|>println
resp.status|>println












































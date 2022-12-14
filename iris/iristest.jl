##############################################################
# iris dataset from Adrian Salceanu julia projects book


##############################################################
# init env

using Pkg
Pkg.activate(".")
Pkg.instantiate()

deps=["RDatasets","Gadfly","JSON"]

if abspath(PROGRAM_FILE)==@__FILE__
  for p in deps
    Pkg.add(p)
  end
  exit(0)
end


useit="using "*join([deps...,"LibBSON"],",")
Meta.parse(useit)|>eval


##############################################################
# play


iris=dataset("datasets","iris")

#plot(iris, x=:SepalLength, y=:PetalLength, color=:Species)

#plot(iris, x=:Species, y=:PetalLength, Geom.boxplot)

#plot(iris, x=:PetalWidth, color=:Species, Geom.histogram)


# a mongoc reszt inkabb hagytam
#script (python)

import clingo
from clingo import Function, Model
import sys

models = []

def getModels():
    return models

def split(model):
    return sorted(str(model).split(" "))

def fun(name, model):
    return Function(name, model) if len(model) > 0 else Function(name)

def on_model(model):
    models.append(fun("model", split(model)))
    models.append(fun("shown", sorted(model.symbols(shown=True))))
    models.append(fun("atoms", sorted(model.symbols(atoms=True))))
    models.append(fun("terms", sorted(model.symbols(terms=True))))
    models.append(fun("csp",   sorted(model.symbols(csp=True))))

def main(prg):
    prg.ground([("base", [])])
    prg.solve(on_model=on_model)
    prg.ground([("result", [])])
    prg.solve()

#end.

$1 $= 11.
{ b }.
c.
$x $= 42.
$y(1) $= 13.
$y(2) $= 23.
$z $= 7.
#show $1.
#show c/0.
#show a : b.
#show $x/0.
#show $y(1) : b.
#show $y(2) : not b.
#show $y(3) : b.

#program result.
res(X) :- X = @getModels(). 
#show res/1.


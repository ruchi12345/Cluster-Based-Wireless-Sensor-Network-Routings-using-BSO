function fitness=Fit_BSA(object, select_pressure)

Nind=length(object);
SP=max([0, min([2,select_pressure])]);

[temp, inx]=sort(object);

for pos=1:Nind
    fitness(pos)=2-SP+2*(SP-1)*(pos-1)/(Nind-1);
end

fitness=[fitness(inx)]';

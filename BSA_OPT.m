function new_popu = BSA_OPT(object, popu, bit_len, xover_rate, mut_rate, elite)

new_popu = popu;
popu_s = size(popu, 1);
string_leng = size(popu, 2);
var_n=string_leng/bit_len;
I=find(object<=0);
if ~isempty(I), object(I)=0.0*ones(size(I)); end

fitness=object;
if (rand>0.5)
   rand('state',sum(100*clock))
   fitness=Fit_BSA(fitness,min([2, max([1.2, 3*rand])]));
end

%----------------------------------------------------------------------
% ====== ELITISM: find the best two and keep them in index1 and index2
if elite==1
   tmp_fitness = object;
   [junk, index1] = max(tmp_fitness);	% find the best
   tmp_fitness(index1) = min(tmp_fitness);  % Change it to a small value for next max finding
   [junk, index2] = max(tmp_fitness);	% find the second best
   % Put the best 2 into new_popu for xover and mutation later
   %new_popu([1 2], :) = popu([index1 index2], :);  % Save the best two chromosomes for Elitism=1
end;

% ====== SELECTION and CROSSOVER
for i = 4:popu_s/2,   % The first is untouched because of Elitism. 
	% === Select two parents based on their scaled fitness values

    c1=ceil(rand*(popu_s));
    c2=ceil(rand*(popu_s));
    c3=ceil(rand*(popu_s));
    c4=ceil(rand*(popu_s));
    c5=ceil(rand*(popu_s));    
    c6=ceil(rand*(popu_s));
    c7=ceil(rand*(popu_s));
    c8=ceil(rand*(popu_s));    
    c9=ceil(rand*(popu_s));    
    c10=ceil(rand*(popu_s));      
    order=[c1 c2 c3 c4 c5 c6 c7 c8 c9 c10];
    [v,h]=max([object(c1) object(c2) object(c3) object(c4) object(c5) object(c6) object(c7) object(c8) object(c9) object(c10)]);
    parent1=popu(order(h),:);
  
    c1=ceil(rand*(popu_s));
    c2=ceil(rand*(popu_s));
    c3=ceil(rand*(popu_s));
    c4=ceil(rand*(popu_s));
    c5=ceil(rand*(popu_s));    
    c6=ceil(rand*(popu_s));
    c7=ceil(rand*(popu_s));
    c8=ceil(rand*(popu_s));    
    c9=ceil(rand*(popu_s));    
    c10=ceil(rand*(popu_s));      
    order=[c1 c2 c3 c4 c5 c6 c7 c8 c9 c10];
    [v,h]=max([object(c1) object(c2) object(c3) object(c4) object(c5) object(c6) object(c7) object(c8) object(c9) object(c10)]);
    parent2=popu(order(h),:);
    
	% === Do crossover
	if rand < xover_rate,
       % Perform crossover operation
	   xover_point = ceil(rand*(bit_len-1));   
       K=-bit_len;
       for J=1:var_n
         K=K+bit_len;
         new_popu(i*2-1, K+1:K+bit_len) = ...
		 [parent1(K+1:K+xover_point) parent2(K+xover_point+1:K+bit_len)];
		 new_popu(i*2,   K+1:K+bit_len) = ...
		 [parent2(K+1:K+xover_point) parent1(K+xover_point+1:K+bit_len)];
       end;
	end
end

% ====== MUTATION (elites are not subject to this.)
mask = rand(popu_s, string_leng) < mut_rate;
new_popu = xor(new_popu, mask);

%-----------------------------------------------------------------
% restore the elites if elite==1
if elite==1,
   new_popu([1:4], :) = popu([index1 index2 index1 index2], :); % Save the best only back to new_popu
end;
%--------------------END-----------------------------------------
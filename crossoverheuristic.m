function xoverKids  = crossoverheuristic(parents,options,GenomeLength,~,thisScore,thisPopulation,ratio)if nargin < 7 || isempty(ratio)
    ratio = 1.2;
end

% How many children am I being asked to produce?
nKids = length(parents)/2;
% Extract information about linear constraints, if any
linCon = options.LinearConstr;
constr = ~isequal(linCon.type,'unconstrained');
% Allocate space for the kids
xoverKids = zeros(nKids,GenomeLength);

% To move through the parents twice as fast as thekids are
% being produced, a separate index for the parents is needed
index = 1;

for i=1:nKids
    % get parents
    parent1 = thisPopulation(parents(index),:);
    score1 = thisScore(parents(index));
    index = index + 1;
    parent2 = thisPopulation(parents(index),:);
    score2 = thisScore(parents(index));
    index = index + 1;
    
    % move a little past the better away from the worst
    if(score1 < score2) % parent1 is the better of the pair
        delta = ratio .* (parent1 - parent2);
        delta(linCon.IntegerVars) = round(delta(linCon.IntegerVars));        
        xoverKids(i,:) = parent2 + delta;
    else % parent2 is the better one
        delta = ratio .* (parent2 - parent1);
        delta(linCon.IntegerVars) = round(delta(linCon.IntegerVars));        
        xoverKids(i,:) = parent1 + delta;
    end
    % Make sure that offspring are feasible w.r.t. linear constraints
    if constr
        feasible = isTrialFeasible(xoverKids(i,:)',linCon.Aineq,linCon.bineq,linCon.Aeq, ...
                            linCon.beq,linCon.lb,linCon.ub,options.LinearConstraintTolerance);
        if ~feasible % Kid is not feasible
          % Children are arithmetic mean of two parents (feasible w.r.t
          % linear constraints)
          alpha = rand;
          xoverKids(i,:) = alpha*parent1 + (1-alpha)*parent2;
        end
    end
end
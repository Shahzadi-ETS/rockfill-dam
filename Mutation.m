%Mutation part is Copied from GA matlab original code

function y=Mutation(x,mu,VarMin,VarMax)

    nVar=numel(x);
    
    nmu=ceil(mu*nVar);
    
    j=randsample(nVar,nmu);
    
    sigma=0.1*(VarMax-VarMin);
    
    y=x;
    y(j)=x(j)+sigma(j)*randn(size(j));
    
    y=max(y,VarMin);
    y=min(y,VarMax);

end
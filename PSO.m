clc; 
close all; 
clear all
tic;

 fun = @Objective_function;
 lb = [68000 40.85  0.35 21.37 8.5 144500 45.15 0.20 22.5 12.75 93500 42.85 0.35 21.375 8.5];  % For HS , N=5, 3D problem. 
 ub = [92000 45.15  0.7 23.62 11.5 195500 49.15 0.26 24.85 17.25 126500 47.15 0.7 23.375 11.5];
 options = optimoptions('particleswarm','PlotFcn',@pswplotbestf);  
 nvars = 15; 
[x,fval,exitflag,output] = particleswarm(fun,nvars,lb,ub,options)
 toc;
 
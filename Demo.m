%_________________________________________________________________________%
%  
%       Binary Optimization Using Hybrid GWO for Feature Selection 
%           By: Qasem Al-Tashi, Said Jadid, Helmi Rais, 
%              Seyedali Mirjalili and Hitham Alhussain
%           email: qasemacc22@gmail.com
% 
%                Main paper: Q. Al-Tashi                                  %
%                 Binary Optimization Using Hybrid 
%               Grey Wolf Optimization for Feature Selection 
%                           
%               IEEE Access ( Early Access )                              %
%               DOI: 10.1109/ACCESS.2019.2906757                          %
%                                                                         %
%  Developed in MATLAB R2017a                                             %
%                                                                         %
%  the original code of GWO is availble on                                %
%                                                                         %
%       Homepage: http://www.alimirjalili.com                             %
%                e-Mail: ali.mirjalili@gmail.com                          %
%                      
%_________________________________________________________________________%
% I acknowledge that this version of BGWOPSO has been written using
% a large portion of the following code:

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MATLAB Code for                                                  %
%                                                                   %
%  Hybrid Algorithm of Particle Swarm Optimization and Grey
%      Wolf Optimizer for Improving Convergence Performance         %
%                                                                   %
%                                                                   %
%  According to:                                                    %
%  Narinder Singh and S. B. Singh, November 2017                    %

%                      narindersinghgoria@ymail.com                 %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;
clear all;
clc;
global A trn vald ;
SearchAgents_no=10; % Number of search agents
Max_iteration=100; % Maximum numbef of iterations
A=load ('covid.dat');
r=randperm(size(A,1));
trn=r(1:floor(length(r)/2));
vald=r(floor(length(r)/2)+1:end);
tic
[Best_score,Best_pos,Convergence_curve]=BGWOPSO(SearchAgents_no,(Max_iteration),0,1,size(A,2)-1,'AccSz');
time = toc;
acc = Acc(Best_pos);
fprintf('hybrid Acc  %f\thybrid Fitness:  %f\thybridSolution:  %s\thybridDimention: %d\thybridTime:  %f\n',acc,Best_score,num2str(Best_pos,'%1d'),sum(Best_pos(:)),time);



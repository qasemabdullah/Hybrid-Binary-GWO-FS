%_________________________________________________________________________%
%  
%       Binary Optimization Using Hybrid GWO for Feature Selection 
%           By: Qasem Al-Tashi, Said Jadid, Helmi Rais, 
%              Seyedali Mirjalili and Hitham Alhussain
%           email: qasemacc22@gmail.com
% 
% Main paper: Q. Al-Tashi                                  %
%         Binary Optimization Using Hybrid 
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

function acc=Acc(x)
%we used this function to calculate the accuracy 
global A trn vald 
SzW=0.01;
 x=x>0.5;
 x=cat(2,x,zeros(size(x,1),1));
 x=logical(x);

if sum(x)==0
    y=inf;
    return;
end
c = knnclassify(A(vald,x),A(trn,x),A(trn,end));
cp = classperf(A(vald,end),c);
% y=(1-SzW)*(1-cp.CorrectRate)+SzW*sum(x)/(length(x)-1);
acc = cp.CorrectRate;
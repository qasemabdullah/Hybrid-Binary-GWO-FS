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


% Grey Wolf Optimizer
function [Alpha_score,Alpha_pos,Convergence_curve]=BGWOPSO(SearchAgents_no,Max_iter,lb,ub,dim,fobj)
% initialize alpha, beta, and delta_pos
Alpha_pos=zeros(1,dim);
Alpha_score=inf; %change this to -inf for maximization problems

Beta_pos=zeros(1,dim);
Beta_score=inf; %change this to -inf for maximization problems

Delta_pos=zeros(1,dim);
Delta_score=inf; %change this to -inf for maximization problems

%Initialize the positions of search agents
Positions=initialization(SearchAgents_no,dim,1,0)>0.5;

%Positions=initialization(SearchAgents_no,dim,ub,lb);
Convergence_curve=zeros(1,Max_iter);
velocity = .3*randn(SearchAgents_no,dim) ;
w=0.5+rand()/2;
l=0;% Loop counter

% Main loop
while l<Max_iter
    for i=1:size(Positions,1)
        
        % Calculate objective function for each search agent
        fitness=feval(fobj,Positions(i,:));
        
        % Update Alpha, Beta, and Delta
        if fitness<Alpha_score
            Alpha_score=fitness; % Update alpha
            Alpha_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness<Beta_score
            Beta_score=fitness; % Update beta
            Beta_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness>Beta_score && fitness<Delta_score
            Delta_score=fitness; % Update delta
            Delta_pos=Positions(i,:);
        end
    end
    
    
    a=2-l*((2)/Max_iter); % a decreases linearly fron 2 to 0
    
    % Update the Position of search agents including omegas
    for i=1:size(Positions,1)
        for j=1:size(Positions,2)
            
            r1=rand(); % r1 is a random number in [0,1]
            r2=rand(); % r2 is a random number in [0,1]
            
            A1=2*a*r1-a; % Equation (3.3)
            C1=0.5;
             D_alpha=abs(C1*Alpha_pos(j)-w*Positions(i,j));
            v1=sigmf(-A1*D_alpha,[10, 0.5]);
            if v1<rand
                v1=0;
            else
                v1=1;
            end
            X1=(Alpha_pos(j)+v1)>=1;
          
            r1=rand();
            r2=rand();
            
            A2=2*a*r1-a; % Equation (3.3)
            C2=0.5;
            
            D_beta=abs(C2*Beta_pos(j)-w*Positions(i,j)); % Equation (3.5)-part 2
           v1=sigmf(-A2*D_beta,[10 0.5]);
            if v1<rand
                v1=0;
            else
                v1=1;
            end
            
            X2=(Beta_pos(j)+v1)>=1 ;
            
            
            r1=rand();
            r2=rand();
            r3=rand();
            A3=2*a*r1-a; % Equation (3.3)
            C3=0.5;
            D_delta=abs(C3*Delta_pos(j)-w*Positions(i,j)); % Equation (3.5)-part 3
            v1=sigmf(-A3*D_delta,[10 0.5]);%eq. 25
            if v1<rand
                v1=0;
            else
                v1=1;
            end
            X3=(Delta_pos(j)+v1)>=1;
            
            % velocity updation
            velocity(i,j)=w*(velocity(i,j)+C1*r1*(X1-Positions(i,j))+C2*r2*(X2-Positions(i,j))+C3*r3*(X3-Positions(i,j)));
          
        
            % positions update
            xx=sigmf((X1+X2+X3)/3,[10 0.5])+velocity(i,j);
            if xx<rand
                xx=0;
            else
                xx=1;
            end
            Positions(i,j)=xx;% Equation (3.7)            
        end
        
        fprintf('%f:\t',Alpha_score);
        fprintf('%d',Alpha_pos(:));
        fprintf('\n');
    end
    
    l=l+1;
    Convergence_curve(l)=Alpha_score;
end

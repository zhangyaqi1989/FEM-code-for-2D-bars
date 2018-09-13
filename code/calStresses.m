function [epsilon,sigma] = calStresses(sigmaZero,epsilonZero,eleNum, nodeCoordinate,...
    eleNodes, displacements, material)

%   This function calculates strains and stresses
%    
%   INPUT
%   sigmaZero: initial sress
%   epsilonZero: initial strain
%   eleNum: # of elements
%   nodeCoordinate: global coordinate of nodes
%   eleNodes: the global node number of every element
%   displacements: displacement of every dof
%   material: material property
%
%   OUTPUT
%   sigma: stress of every element
%   spsilon: strain of every element

% initial stress
sigma = zeros(eleNum,1);
epsilon = zeros(eleNum,1);

% x is X coordinate, y is Y coordinate
x = nodeCoordinate(:,1);
y = nodeCoordinate(:,2);

for ele = 1:eleNum
    
    index = eleNodes(ele, 1 : 2);
    i = index(1);
    j = index(2);
    
    eleDof = [i*2-1, i*2, j*2-1, j*2];
    
    % Calculate the length of element
    deltX = x(j) - x(i);
    deltY = y(j) - y(i);
    eleLength = sqrt(deltX^2 + deltY^2);
    
    % Get elastic modulus
    E = material(eleNodes(ele,3),2);
    
    % Calculate the cos and sin
    C = deltX / eleLength;
    S = deltY / eleLength;
    
    % Calculate element strain
    epsilon(ele) = 1/eleLength * [-C -S C S] * displacements(eleDof);
    
    % Calculate element stress
    sigma(ele) = sigmaZero(ele) + E * (epsilon(ele) - epsilonZero(ele));
    
end


end


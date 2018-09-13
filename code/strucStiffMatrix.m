function [stiffMatrix] = strucStiffMatrix(nodeNum, dofPerNode, eleNum,...
    nodePerEle, nodeCoordinate, eleNodes, material)

% This function calculates the structure stiffness matrix
%   INPUT
%   nodeNum: # of nodes
%   dofPerNode: # of DOFs per node
%   eleNum: # of elements
%   nodePerEle: # of nodes per element
%   nodeCoordinate: global coordinate of nodes
%   eleNodes: the global node number of every element
%   material: material property
%
%   OUTPUT
%   stiffMatrix: structure stiffness matrix

% initial stiffness matrix
stiffMatrix = zeros(nodeNum*dofPerNode, nodeNum*dofPerNode);

% x is X coordinate, y is Y coordinate
x = nodeCoordinate(:, 1);
y = nodeCoordinate(:, 2);

for ele = 1:eleNum
    
    index = eleNodes(ele, 1 : 2);
    i = index(1);
    j = index(2);
    eleDof = [i*2-1, i*2, j*2-1, j*2];
    
    % Calculate element length
    deltX = x(j) - x(i);
    deltY = y(j) - y(i);
    eleLength = sqrt(deltX^2 + deltY^2);
    
    % Get cross sectional area and elastic modulus
    A = material(eleNodes(ele,3),1);
    E = material(eleNodes(ele,3),2);
    
    % Calculate cos and sin
    C = deltX / eleLength;
    S = deltY / eleLength;
    
    % Calculate element stiffness matrix
    eleStiff = E * A / eleLength * ...
        [C*C C*S -C*C -C*S; C*S S*S -C*S -S*S;...
        -C*C -C*S C*C C*S; -C*S -S*S C*S S*S];
    
    % Assemble structure stiffness matrix
    stiffMatrix(eleDof, eleDof) = stiffMatrix(eleDof, eleDof) + eleStiff;
       
end

% display('Structure Stiffness Matrix');
% display(stiffMatrix);

end


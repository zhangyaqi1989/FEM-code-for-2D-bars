function [ thermalNodeLoad ] = thermalForce(nodeNum, dofPerNode, eleNum, ...
   nodeCoordinate, eleNodes, material, alpha)
% This function calculates termal load terms
% 
% INPUT
% nodeNum: # of nodes
% dofPerNode: # of dof per node
% eleNum: # of elements
% nodeCoordinate: coordinates of every node
% eleNodes: the global node number of every element
% material: material property
% alpha: coefficient of thermal expansion
%
% OUTPUT
% thermaNodeLoad: node load caused by thermal

x = nodeCoordinate(:, 1);
y = nodeCoordinate(:, 2);

thermalNodeLoad = zeros(nodeNum*dofPerNode, 1);

for ele = 1:eleNum

    index = eleNodes(ele, 1 : 2);
    i = index(1);
    j = index(2);
    eleDof = [i*2-1, i*2, j*2-1, j*2];
    
    deltX = x(j) - x(i);
    deltY = y(j) - y(i);
    L = sqrt(deltX^2 + deltY^2);
    
    % calculate average temperature
    avrT = (temperature(x(j)) + temperature(x(i)))/2;
    
    A = material(eleNodes(ele,3), 1);
    E = material(eleNodes(ele,3), 2);
    l = deltX/L;
    m = deltY/L;
    
    P = A*E*alpha*avrT*[-1;1];
    
    thermalNodeLoad(eleDof) =  thermalNodeLoad(eleDof) + [l,0; m,0; 0,l; 0,m]*P;
    
end

end


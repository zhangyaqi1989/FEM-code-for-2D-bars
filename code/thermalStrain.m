function [epsilonZero] = thermalStrain(nodeCoordinate, ...
    eleNodes, eleNum, alpha)
% This function calculates the initial strain caused by thermal
% 
% INPUT
% nodeCoordinate: coordinates of every node
% eleNodes: the global node number of every element
% eleNum: # of elements
% material: material property matrix
% alpha: coefficient of thermal expansion
%
% OUTPUT
% epsilonZero: initial strain caused by thermal

epsilonZero = zeros(eleNum,1);

for ele = 1:eleNum
    x1 = nodeCoordinate(eleNodes(ele,1), 1);
    x2 = nodeCoordinate(eleNodes(ele,2), 1);
    T1 = temperature(x1);
    T2 = temperature(x2);
%     E = material(eleNodes(ele,3),2);
    epsilonZero(ele) = alpha*(T1 + T2)/2;
end

end


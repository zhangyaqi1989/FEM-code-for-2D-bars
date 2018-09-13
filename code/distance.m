function D = distance(displacements, eleNodes)
% This function calculates point of impact change due to deformation 
%
% Input
% displacments: displacements vector
% eleNodes: the global node number of every element
%
% Output
% D: point of impact change

node1 = eleNodes(33, 1);
node2 = eleNodes(33, 2);

dx1 = displacements(node1 * 2 - 1);
dx2 = displacements(node2 * 2 - 1);


D = (abs(dx1-dx2)/(10*0.3048)) * 15 * 1609.34;


end


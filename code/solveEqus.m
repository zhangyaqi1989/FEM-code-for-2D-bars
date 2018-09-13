function [displacements] = solveEqus(nodeNum, dofPerNode,...
    prescribedDof, stiffMatrix, ExForce)

%   This function adds BCs and solves the reduced equilibrium equations to get displacements
%
%   INPUT
%   nodeNum: # of nodes
%   dofPerNode: # of DOFs per node
%   prescribedDof: prescribed dofs
%   stiffMatrix: structure stiffness matrix
%   ExForce: external force vector
%
%   OUTPUT
%   displacements: displacments vector

% filter the unknown DOFs
unknownDof = setdiff(1:nodeNum*dofPerNode', prescribedDof);

% solve the reduced equilibrium equations
u = stiffMatrix(unknownDof, unknownDof)\ExForce(unknownDof);

% initial displacements vector
displacements = zeros(nodeNum*dofPerNode, 1);

displacements(unknownDof) = u;

% display('Displacements [m]');
% display(displacements);

end


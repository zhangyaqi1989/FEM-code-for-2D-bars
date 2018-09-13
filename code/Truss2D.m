% Clear all the variables in workspace
clear all

% clear the screen
clc

% Import data from file
% [nodeNum, dofPerNode, eleNum, nodePerEle, spaceDim, materialSet,...
% nodeCoordinate, ExForce, eleNodes, prescribedDof, material, title]...
% = importData('Bar Test Program.txt');

[nodeNum, dofPerNode, eleNum, nodePerEle, spaceDim, materialSet,...
nodeCoordinate, ExForce, eleNodes, prescribedDof, material, title]...
= importData('2-D Truss Example.txt');

% [nodeNum, dofPerNode, eleNum, nodePerEle, spaceDim, materialSet,...
% nodeCoordinate, ExForce, eleNodes, prescribedDof, material, title] = importData('Steel Structure.txt');
% 
% % change ft to inch
% nodeCoordinate = 12*nodeCoordinate;


% [nodeNum, dofPerNode, eleNum, nodePerEle, spaceDim, materialSet,...
% nodeCoordinate, ExForce, eleNodes, prescribedDof, material, title] = importData('Test1.txt');
% [nodeNum, dofPerNode, eleNum, nodePerEle, spaceDim, materialSet,...
% nodeCoordinate, ExForce, eleNodes, prescribedDof, material, title]...
% = importData('Bar Test Program.txt');

% termal expansion
% alpha = 7E-6;
% [ ExForce ] = thermalForce(nodeNum, dofPerNode, eleNum, ...
%    nodeCoordinate, eleNodes, material, alpha);

% Calculate and assemble structure stiffness matrix
[stiffMatrix] = strucStiffMatrix(nodeNum, dofPerNode, eleNum,...
    nodePerEle, nodeCoordinate, eleNodes, material);

% Test
% ExForce = [0;0;1000000;0;0;0];

% Add BCs and solve the reduced equilibrium equations
[displacements] = solveEqus(nodeNum, dofPerNode,...
    prescribedDof, stiffMatrix, ExForce);

% Draw the structure befor and after deformation
draw(nodeCoordinate, displacements, eleNodes);


% Calculate element strain and stress
sigmaZero = zeros(eleNum, 1);
epsilonZero = zeros(eleNum, 1);
[epsilon,sigma] = calStresses(sigmaZero,epsilonZero,eleNum, nodeCoordinate,...
    eleNodes, displacements, material);

% output to command window
Output(displacements, epsilon, sigma, title);

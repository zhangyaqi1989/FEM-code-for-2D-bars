% This script calculates the 2-D truss example
% Clear all the variables in workspace
clear all

% clear the screen
clc

% Import data from file

[nodeNum, dofPerNode, eleNum, nodePerEle, spaceDim, materialSet,...
nodeCoordinate, ExForce, eleNodes, prescribedDof, material, title]...
= importData('2-D Truss Example.txt');

% Calculate and assemble structure stiffness matrix
[stiffMatrix] = strucStiffMatrix(nodeNum, dofPerNode, eleNum,...
    nodePerEle, nodeCoordinate, eleNodes, material);

% Add BCs and solve the reduced equilibrium equations
[displacements] = solveEqus(nodeNum, dofPerNode,...
    prescribedDof, stiffMatrix, ExForce);

% Draw the structure befor and after deformation
draw(nodeCoordinate, displacements, eleNodes);

% calculate element stress and strain
sigmaZero = zeros(eleNum, 1);
epsilonZero = zeros(eleNum, 1);
[epsilon,sigma] = calStresses(sigmaZero,epsilonZero,eleNum, nodeCoordinate,...
    eleNodes, displacements, material);

% output to command window
Output(displacements, epsilon, sigma, title);
% This script calculates the steel structure under wind load
% Clear all the variables in workspace
clear all

% clear the screen
clc

% import data from file and store them in variables
[nodeNum, dofPerNode, eleNum, nodePerEle, spaceDim, materialSet,...
nodeCoordinate, ExForce, eleNodes, prescribedDof, material, title]...
= importData('Steel Structure.txt');

% change units to international units
unitChange;

% Calculate and assemble structure stiffness matrix
[stiffMatrix] = strucStiffMatrix(nodeNum, dofPerNode, eleNum,...
    nodePerEle, nodeCoordinate, eleNodes, material);


% Add BCs and solve the reduced equilibrium equations
[displacements] = solveEqus(nodeNum, dofPerNode,...
    prescribedDof, stiffMatrix, ExForce);

% Draw the structure befor and after deformation
draw(nodeCoordinate, displacements, eleNodes);


% Calculate the strain and stress
sigmaZero = zeros(eleNum, 1);
epsilonZero = zeros(eleNum, 1);
[epsilon,sigma] = calStresses(sigmaZero,epsilonZero,eleNum, nodeCoordinate,...
    eleNodes, displacements, material);

% output to command window
Output(displacements, epsilon, sigma, title);

% Calculate point of impact change
D = distance(displacements, eleNodes);
disp(['D = ', num2str(D), ' m']);
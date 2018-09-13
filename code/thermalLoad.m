% This script calculates steel structure under thermal load
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


% use termal load to replace external force vector
alpha = 7E-6;
thermalNodeLoad = thermalForce(nodeNum, dofPerNode, eleNum, ...
   nodeCoordinate, eleNodes, material, alpha);

ExForce = thermalNodeLoad;

% Calculate and assemble structure stiffness matrix
[stiffMatrix] = strucStiffMatrix(nodeNum, dofPerNode, eleNum,...
    nodePerEle, nodeCoordinate, eleNodes, material);

% Add BCs and solve the reduced equilibrium equations
[displacements] = solveEqus(nodeNum, dofPerNode,...
    prescribedDof, stiffMatrix, ExForce);


% Draw the structure befor and after deformation
draw(nodeCoordinate, displacements, eleNodes);


% Calculate element strain and stress
sigmaZero = zeros(eleNum, 1);
epsilonZero = thermalStrain(nodeCoordinate, ...
    eleNodes, eleNum, alpha);
[epsilon,sigma] = calStresses(sigmaZero,epsilonZero,eleNum, nodeCoordinate,...
    eleNodes, displacements, material);


% output to command window
Output(displacements, epsilon, sigma, title);

% Calculate point of impact change
D = distance(displacements, eleNodes);
disp(['D = ', num2str(D), ' m']);

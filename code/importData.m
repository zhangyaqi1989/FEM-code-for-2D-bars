function [nodeNum, dofPerNode, eleNum, nodePerEle, spaceDim, materialSet,...
nodeCoordinate, ExForce, eleNodes, prescribedDof, material, title] = importData(fileName)

% This function imports data from txt file and initializes varibles
%   INPUT
%   fileName: file name

%   OUTPUT
%   nodeNum: # of nodes
%   dofPerNode: # of DOFs per node
%   eleNum: # of elements
%   nodePerEle: # of nodes per element
%   spaceDim: space dimensions
%   materialSet: # of material sets
%   nodeCoordinate: global coordinate of nodes
%   ExForce: external force vector
%   eleNodes: the global node number of every element
%   prescribedDof: prescribed DOF
%   material: material property
%   title: question name (like steel structure or 2D truss)


% clear all;
% clc;

fid = fopen(fileName);
%fid = fopen('Steel Structure New.txt');
%fid = fopen('Bar Test Program.txt');

% short description of the model to be analyzed
tline = fgetl(fid);
% disp(tline);
title = tline; % store question name in title

% Control information
tline = fgetl(fid);

line = textscan(tline, '%d %d %d %d %d %d', 1);
line = [line{:}];
%line = cell2mat(line);

% import control imformation
nodeNum = line(1);
dofPerNode = line(2);
eleNum = line(3);
nodePerEle = line(4);
spaceDim = line(5);
materialSet = line(6);

% initialize variables
nodeCoordinate = zeros(nodeNum, dofPerNode);
ExForce = zeros(nodeNum*dofPerNode, 1);
prescribedDof = zeros(nodeNum*dofPerNode, 1); %%%% remove ' modified by Yaqi
material = zeros(materialSet, 2);
eleNodes = zeros(eleNum, nodePerEle + 1); % the last column stores material set num

% import node information
for i = 1:nodeNum
    tline = fgetl(fid);
    line = textscan(tline, '%f %f %f %f', 1);
    line = cell2mat(line);
    node = line(1);
    preDof = line(2);
    if(floor(preDof/10) == 1)
        prescribedDof(node*2 - 1) = 1;
    end
    if(mod(preDof,10) == 1)
        prescribedDof(node*2) = 1;
    end
    
    nodeCoordinate(node, 1) = line(3);
    nodeCoordinate(node, 2) = line(4);
    
    tline = fgetl(fid);
    line = textscan(tline, '%f %f', 1);
    line = [line{:}];
    ExForce(node*2-1,1) = line(1);
    ExForce(node*2,1) = line(2);
end

% import element information
for i = 1:eleNum
    tline = fgetl(fid);
    line = textscan(tline, '%d %d %d %d', 1);
    line = [line{:}];
    element = line(1);
    eleNodes(element, 1) = line(3);
    eleNodes(element, 2) = line(4);
    eleNodes(element, 3) = line(2);
end

% import material properties
 for i = 1:materialSet
    tline = fgetl(fid);
    line = textscan(tline, '%f %f %f', 1);
    line = cell2mat(line); %need to discuss
    mSet = line(1);
    material(mSet, 1) = line(2);
    material(mSet, 2) = line(3);
     
 end
 fclose(fid);
 
% standardize prescribedDof format
 sum1 = sum(prescribedDof);
 temp = zeros(sum1,1);
 length1 = length(prescribedDof);
 index =1;
 for i = 1:length1
     if (prescribedDof(i) == 1) 
         temp(index) = i;
         index = index + 1;
     end
 end
 
 prescribedDof = temp;
 
 % clear varibles not used
 clear temp tline sum1 node mSet line index i fid preDof length1 element
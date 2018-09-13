function draw(nodeCoordinate, displacements, eleNodes)

%   This function plots the original and deformed shape
%
%   INPUT
%   nodeCoordinate: coordinates of nodes
%   displacements: displacements
%   eleNodes: eleNodes: the global node number of every element

[row, column] = size(eleNodes);
lw = 1.5;

for i = 1:row
    node1 = eleNodes(i,1);
    node2 = eleNodes(i,2);
    
    node1cor = nodeCoordinate(node1,:);
    dx1 = displacements(node1 * 2 - 1);
    dy1 = displacements(node1 * 2);
    dx2 = displacements(node2 * 2 - 1);
    dy2 = displacements(node2 * 2);
    node2cor = nodeCoordinate(node2,:);
    
    x(1) = node1cor(1,1);
    x(2) = node2cor(1,1);
    y(1) = node1cor(1,2);
    y(2) = node2cor(1,2); 
    plot(x,y,'r-', 'linewidth', lw);
    hold on;
    x(1) = x(1) + dx1;
    x(2) = x(2) + dx2;
    y(1) = y(1) + dy1;
    y(2) = y(2) + dy2;
    plot(x,y,'b--', 'linewidth', lw);
    hold on;
    %plot(node1cor,node2cor,'-');  
end

% xlim([-5 10]), ylim([0 80]);
% daspect([1 1 1]);

xlabel('X');
ylabel('Y');
title('Original and Deformed Shape');
legend('Original Shape', 'Deformed Shape');

end


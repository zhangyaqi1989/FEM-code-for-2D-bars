function Output(displacements, epsilon, sigma, title)

% this function output results to command window
% 
% INPUT
% displacements: displacement of every dof
% sigma: stress of every element
% title: question name

disp('============================================================');
disp(title);

disp('============================================================');
formatSpec = 'DOF%3d : %0+3.8f \n';
d = size(displacements);
disp('Displacements [m]')
for i = 1:d(1)
    fprintf(formatSpec, i, displacements(i));
%     disp(['DOF ', num2str(i), ':  ', num2str(displacements(i))]);
end
disp('============================================================');
d = size(epsilon);
disp('Element Strains')
formatSpec = '#%03d : %0-+12.8e \n';

for i = 1:d(1)
    fprintf(formatSpec, i, epsilon(i));
%     disp(['#', num2str(i), ':  ', num2str(sigma(i))]);
end

disp('============================================================');
d = size(sigma);
disp('Element Stresses [Pa]')
formatSpec = '#%03d : %0-+12.8e \n';

for i = 1:d(1)
    fprintf(formatSpec, i, sigma(i));
%     disp(['#', num2str(i), ':  ', num2str(sigma(i))]);
end
disp('============================================================');
end


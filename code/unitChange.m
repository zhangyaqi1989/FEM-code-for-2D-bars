% change ft to m 
for i = 1:nodeNum
    nodeCoordinate(i,:) = nodeCoordinate(i,:) * 0.3048;
end

% change material properties unit: in2 to m2; psi to pascal
for j = 1:materialSet
    material(j,1) = material(j,1) * 0.0254 * 0.0254;
    material(j,2) = material(j,2) * 6894.75729;
end

% change force g = 9.80665 kg/s2
for k = 1:nodeNum*dofPerNode
    ExForce(k) = ExForce(k) * 0.453592 * 9.80665;
end
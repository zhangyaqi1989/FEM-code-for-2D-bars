function [T] = temperature( x )
% This function calculate the temperature T
%   
%   INPUT
%   x is the x coordinate
%   
%   OUTPUT
%   T temperature

T = 30*(1 - x/(5 * 0.3048));
% T = 30*(1 - x/20); % for test
end


function [output_points, tangent] = compSpline(control_points, h)
% compSpline evaluates a Bezier spline with the specified degree
%
% INPUTS
% ------
% control_points    - input 3 or 4 points in a 3x2 or 4x2 matrix [xs, ys]
% h                 - the interval to use for evaluation, default = 0.05
%
% OUTPUTS
% -------
% output_points - n x 2 matrix of output points [xs; ys]
% tangent       - the tangent at the two end-points [t0; t1]
%
% EXAMPLE
% -------
% [p, t] = compSpline(sp, 0.1);


if nargin < 2
    h = 0.05; 
end

% Get the degree
degree = size(control_points, 1) - 1;

% Compute number of return points
n = floor(1/h) + 1;

%%%%%%%%%%%%%%%%%%%%%%%%
%Quadratic Bezier curve
%%%%%%%%%%%%%%%%%%%%%%%%
if degree == 2
    M =	[1, -2, 1; -2, 2, 0; 1,	0, 0];
    
    % Compute constants [a, b, c]
    abcd = M * control_points;
    a = abcd(1,:);
    b = abcd(2,:);
    c = abcd(3,:);
    
    % Compute at time 0
    P = c;
    dP = b * h + a * h^2;
    ddP = 2*a*h^2;
    
    % Loop
    output_points = zeros(n, size(control_points,2));
    output_points(1,:) = P;
    for i = 2:n
	% Calculate new point
	P = P + dP;
	% Update steps
	dP = dP + ddP;
	% Put back
	output_points(i,:) = P;
    end;
    
    % Tangent: t0 = b
    t0 = b;
    % Tangent: t1 = 2a + b
    t1 = 2*a + b;

    
%%%%%%%%%%%%%%%%%%%%%%%%
%Cubic Bezier curve
%%%%%%%%%%%%%%%%%%%%%%%%
elseif degree == 3
    
    M =	[-1, 3,	-3, 1; 3, -6, 3, 0; -3,	3, 0, 0; 1, 0, 0, 0];
    
    % Compute constants [a, b, c, d]
    abcd = M * control_points;
    a = abcd(1,:);
    b = abcd(2,:);
    c = abcd(3,:);
    d = abcd(4,:);
    
    % Compute at time 0
    P = d;
    dP = c*h + b * h^2 + a * h^3;
    ddP = 2*b*h^2 + 6*a*h^3;
    dddP = 6*a*h^3;
    
    % Loop
    output_points = zeros(n, size(control_points, 2));
    output_points(1,:) = P;
    for i = 2:n
	% Calculate new point
	P = P + dP;
	% Update steps
	dP = dP + ddP;
	ddP = ddP + dddP;
	% Put back
	output_points(i,:) = P;
    end;
    
    % Tangent: t0 = c
    t0 = c;
    % Tangent: t1 = 3a + 2*b + c
    t1 = 3*a + 2*b + c;
    
end

% Put tangents together
tangent = [t0; t1];


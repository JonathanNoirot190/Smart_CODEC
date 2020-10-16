function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

J = 0;
grad = zeros(size(theta));


X = [ones(m, 1) mapFeature(X(:, 2), X(:, 3))];
h = sigmoid(X*theta);
reg = lambda/2*theta'*theta;
reg(1) = 0;
J = -y'*log(h) - (1 - y)'*log(1 - h) + reg;
J /= m;

Dreg = lambda*theta;
Dreg(1)=0;
grad = X'*(h - y) + Dreg;
grad /= m;


end

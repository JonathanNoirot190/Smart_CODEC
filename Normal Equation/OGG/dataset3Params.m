function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma.

C = 1;
sigma = 0.3;

Clist = [0.03, 0.1, 0.3, 1, 3];
sigmalist = [0.03, 0.1, 0.3, 1, 3];

err = 10000;

for i = 1:length(Clist)
  for j = 1:length(sigmalist)
    model = svmTrain(X, y, Clist(i), @(x1, x2) gaussianKernel(x1, x2, sigmalist(j)));
    predictions = svmPredict(model, Xval);
    err_test = mean(double(predictions ~= yval));
    if err_test < err
      err = err_test;
      C = Clist(i);
      sigma = sigmalist(j);
    end
    
  end
  
end



end

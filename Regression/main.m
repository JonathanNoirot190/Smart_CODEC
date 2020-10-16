%Le but de cet algo est de créer une matrice permettant de convertir un fichier 
%flac en fichier ogg pour ensuite créer un format ogg_ia composé du fichier ogg
%et de la matrice, qui, par un simple produit matriciel permet de retrouver le
%format flac

%% Initialization
clear ; close all; clc

load('data');

m = length(X(1, :));

X1 = X;
y1 = y;

for i = m-2:m %Utiliser m pour parcourir le data-set, mais prend beaucoup plus de temps
  X2 = cell2mat(X1(1, i));
  y2 = cell2mat(y1(1, i));
  if i == m-2
    X = X2;
    y = y2;
  else
    X = [X; X2];
    y = [y; y2];
  end
    
end


%On normalise toutes les données, afin qu'elles soient homogènes
%[X, muX, sigmaX] = featureNormalize(X);
%[y, muy, sigmay] = featureNormalize(y);


subplot(3, 1, 1);
plot(X2);
title("Spectre d'un fichier .ogg");
subplot(3, 1, 2);
plot(y2);
title("Spectre d'un fichier .flac");
subplot(3, 1, 3);
plot(y2-X2);
title("Difference entre ogg et flac");

moy = mean(y2 - y2);
error = sqrt(mean((moy - y2).^2))

%  Setup the data matrix appropriately, and add ones for the intercept term
[m, n] = size(X);

% Add intercept term to x and X_test
X = [ones(m, 1) X];
% Initialize fitting parameters
initial_theta = zeros(11, 1);

% Set Options
options = optimset('GradObj', 'on', 'MaxIter', 100);
lambda = 0.1;
% Compute and display initial cost and gradient
[theta1, cost] = ...
	fminunc(@(t)(costFunctionReg(t, X, y(:, 1), lambda)), initial_theta, options);
  
[theta2, cost] = ...
	fminunc(@(t)(costFunctionReg(t, X, y(:, 2), lambda)), initial_theta, options);

m2 = length(X2(:, 1));
%X2_nom = (X2-(muX'.*ones(1, m2))')./(sigmaX'.*ones(1, m2))';
%y2_nom = (y2-(muy'.*ones(1, m2))')./(sigmay'.*ones(1, m2))';

X2_nom = X2;
y2_nom = y2;

predict = zeros(m2, 2);
predict(:, 1) = [ones(m2, 1) mapFeature(X2_nom(:, 1), X2_nom(:, 2))]*theta1;
predict(:, 2) = [ones(m2, 1) mapFeature(X2_nom(:, 1), X2_nom(:, 2))]*theta2;

figure;
subplot(2, 1, 1);
plot(predict);
title("Spectre de la prediction du fichier .ogg en .flac");
subplot(2, 1, 2);
plot(y2_nom);
title("Spectre d'un fichier .flac");

moy = mean(y2 - predict);
error = sqrt(mean((moy - predict).^2))
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

for i = 1:m %Utiliser m pour parcourir le data-set, mais prend beaucoup plus de temps
  X2 = cell2mat(X1(1, i));
  y2 = cell2mat(y1(1, i));
  if i == 1
    X = X2;
    y = y2;
  else
    X = [X; X2];
    y = [y; y2];
  end
    
end

m = length(y);

% Add intercept term to X
X = [ones(m, 1), mapFeature(X(:, 1), X(:, 2))];

% Calculate the parameters from the normal equation
theta = normalEqn(X, y);


m2 = length(X2(:, 1));
X2 = [ones(m2, 1), mapFeature(X2(:, 1), X2(:, 2))];

predict = X2*theta;

figure;
subplot(3, 1, 1);
plot(predict);
title("Spectre de la prediction du fichier .ogg en .flac");
subplot(3, 1, 2);
plot(y2);
title("Spectre d'un fichier .flac");
subplot(3, 1, 3);
plot(y2-predict);
title("Difference entre flac et la prédiction");

moy = mean(y2 - predict);
error = sqrt(mean((moy - predict).^2))
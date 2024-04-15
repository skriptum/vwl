%%****
% Matrizen und Vektoren

vektor = [0.5;1]
matr = [1,2;4,5]

%%***
% Calculations
% like Ax = c

matr * vektor

%%***
% fancy operations

A_1 = inv(matr)
x = A_1 * vektor

%%***
% Matrizen einzelne Spalten

A_1(2,:) % letze Spalte (2)

%%***
% range function

B=[1:0.5:7] % von 1-7 in 0.5 schritten

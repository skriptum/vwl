# 11.11.2021 Fibonacci

### Weiterführung zu Eigenwerten

$  det(A-\lambda I) = p_n(\lambda) = 0$  -> n-tes polynom von lambda

Geomentrische Deutung der EW und EV

![21-11-11_10-46-38](../images/21-11-11_10-46-38.jpg)



Beispiel 86

`Auf einem Markt konkurrieren zu einem Zeitpunkt t = 0 zwei Produkte mit den Marktanteilen 0,3 und 0,7. Bezeichne aij = P (j → i) die Wahrscheinlichkeit, dass ein Kunde in einem Zeitschritt vom Produkt j auf Produkt i wechselt (bzw. nicht wechselt, für j = i). Die Matrix A = (aij) der Käuferfluktuation sei gegeben durch`

Ausgansmatrix $A = \left(\begin{array}{rrr}
0,75 & 0,35 \\ 
0,25 & 0,65 \\
\end{array}\right)$

![21-11-11_11-10-59](../images/21-11-11_11-10-59.jpg)





### Fibonacci

$ F_0 = 1; F_1 = 1 \implies  F_{n +1} =  F_n + F_{n-1}$

Ausdrücken mit Matrizen![21-11-11-11-24-53](../images/21-11-11-11-24-53.jpg)

Berechnen der Potenzen von Matrizen (für $F^n$)

![21-11-11-11-25-50](../images/21-11-11-11-25-50.jpg)



### Verallgemeinerte Eigenvektoren - Hauptvektoren

wenn man zu wenige Eigenvektoren hat = Problem!

#### Beispiel

 $A = \left(\begin{array}{rrr}
0 & 1 \\ 
0 & 0 \\
\end{array}\right)$ hat Eigenwerte $\lambda_1 = \lambda_2 = 0$

**Problem**: nur ein Eigenvektor $v = (1,0)^T$ 

Sagen als: Der Eigenwert $\lambda =0 $ hat 

- algebraische Vielfachheit 2 (Anzahl Eigenwerte), aber nur
- geometrische Vielfachheit 1 (Anzahl Eigenvektoren)* 

normalerweise geometrische = algebraische Vielfachheit

wenn nicht, dann Matrix **nicht diagonalisierbar!**

Rettung: **Hauptvektor**

> **Hauptvektor:** der Vektor $w \in \mathbb{C} $ falls $(A-\lambda I)^m w = 0$ für ein $ m \in \mathbb{N}$ 



#### Beispiel 92: 

![21-11-11-11-55-19](../images/21-11-11-11-55-19.jpg)

![21-11-11-11-56-12](../images/21-11-11-11-56-12.jpg)

Aber: für diese Klausur **nicht relevant** 


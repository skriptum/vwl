# 15.04.2022 Wahrscheinlichkeit

## Bedingte Wahrscheinlichkeit

- **bisher**: Wahrscheinlichkeit von Ereignis A = $P(A)$
- **jetzt**: bedingte Wahrscheinlichkeit von A mit Kenntnis von B 
    - = $P(A|B)$

Notation: $P(A|B) = \frac{P (A\cap B)}{P(B)}$
-> Umstellen $P(A \cap B) = P(A|B) * P(B)$ (**Produktsatz**)

### mehrere Bedingungen

Beispiel Wetter
- Wahrscheinlichkeit von Schirm mitnehmen A
- unter Bedingungen
    - $B_1$ : es regnet
    - $B_2$ : es regnet nicht

Notation: $P(A) = P(A \cap B_{1})+ P(A \cap B_{2})$

## Totale Wahrscheinlichkeit

aus mehreren Bedingungen **=> Satz der totalen Wahrscheinlichkeit**

- Bedingungen $B_{1}, B_{k}$
    - müssen disjunkte, vollständige Zerlegung einer Grundmenge sein

- dann: $P(A)= \sum_{i=1}^{k}P(A|B_{i})* P(B_{i})$



Umkehranalyse: Wahrscheinlichkeit von Bedingung B = $P(B_j | A)$ 

### Satz von Bayes

![2022-04-15_17.50.05](../images/2022-04-15_17.50.05.jpg)

Beispiel: Gerät zur Erkennung von Falschgeld

- A = Gerät erkennt Fälschung
- $B_1$ = Schein ist falsch
- $B_2$ = Schein ist echt

$B_1, B_2$ disjunkte und vollständige Zerlegung der Menge aller Geldscheine



Herstellerangaben zu Wahrscheinlichkeiten

- Erkennungsrate $P(A|B_1) = 0.97$
- Falsch-Positiv-Rate $P(A|B_2) = 0.05$
- Fälschungswahrscheinlichkeit $P(B_1) = 0.0001$



Frage: $P(B_1 | A)$ wie sicher ist der schein gefälscht wenn Gerät piepst

nach Bayes (mit viel Einsetzen): 0.01904 = **2% korrekte Warnungen!**
# 10.01.2022 Korrelation

Bestimmung des Zusammenhangs für höher skalierte Werte als die nominalen

### Pearsons Korrelationskoeffizient 

für *metrische* Merkmale!

2 Merkmale X,Y mit Paaren $(x_1,y_1), ...,(x_n,y_n)$,

Berechnung: ![22-01-10_18-19](../images/22-01-10_18-19.jpg)

Wertebereich: $-1 \le r_{XY} \le 1$ , 

- $|r_{XY}|$ = Zusammenhang
- Einteilung wie bei $K^*$ (stark, schwach,...)
- Vorzeichen => Richtung des Zusammenhangs

alternative Berechnung: ![22-01-10_18-28](../images/22-01-10_18-28.jpg)

#### Beispiel

Prognoziertes Wachstum (X) vs reales Wachstum (Y)

![22-01-10_18-15](../images/22-01-10_18-15.jpg)

Darstellung im Streudiagramm:

![22-01-10_18-16](../images/22-01-10_18-16-1835020.jpg)

Berechneter Korrelationskoeffizient ~0.87 = stark

### Rangkorrelation

für *ordinale* Merkmale

Beispiel: Beliebtheit von 5 Politikern 

![22-01-11_13-12](../images/22-01-11_13-12.jpg)

Problem: die beiden *wenigs* haben keine exakte Bindung

Lösung: beide die Mitte = 3.5 nehmen! (Mittelrangbildung)

![22-01-11_13-18](../images/22-01-11_13-18.jpg)

#### Rangkorrelationskoeffizient

- Wertebereich $-1 \le r_{sp} \le 1$
- Messung der Monotonie
- Zusammenhangstärke : $|r_{sp}|$
- vereinfachte Version, wenn keine Bindungen (Formelsammlung)

aus Pearson abgeleitet, aber mit Ränge statt Werte
$$
r_\text{Sp} = \frac{\sum_{i=1}^n (\text{rang}(x_i) – \overline{\text{rang}(x)}) (\text{rang}(y_i) – \overline{\text{rang}(y)})}{ \sqrt{\sum_{i=1}^n (\text{rang}(x_i) – \overline{\text{rang}(x)})^2} \cdot \sqrt{\sum_{i=1}^n (\text{rang}(y_i) – \overline{\text{rang}(y)})^2} }
$$
Vereinfachung: Rangmittelwerte bilden

- $\overline{\text{rang}(y)} = \overline{\text{rang}(x)}= \frac{n+1}{2}$

Vereinfachter Spearman-Koeffizient:

![22-01-11_13-30](../images/22-01-11_13-30.jpg)



### Interpretation der Korrelation

- keine Wirkrichtung, sondern wechselseitiger **Zusammenhang**
- Korrelation ≠ Kausalität
- Richtung des Zusammenhangs -> bei mind. ordinalen Merkmalen
- für Ursache-Wirkung: **Regression!**


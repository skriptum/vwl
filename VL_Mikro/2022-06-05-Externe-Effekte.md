# 05.06.2022 Externe Effekte

Annahmen des mikroökonomischen neoklassischen Modells: Subjekte tragen Opportunitätskosten ihres Handels selbst

- wenn soziale Grenzkosten nicht kompensiert werden = **externe Effekte**
- Social Marginal Costs SMC > Producers Marginal Cost PMC

| negative Externalitäten                                   | positive Externalitäten                                   |
| --------------------------------------------------------- | --------------------------------------------------------- |
| ![2022-05-31_13.47.41](../images/2022-05-31_13.47.41.jpg) | ![2022-05-31_13.47.57](../images/2022-05-31_13.47.57.jpg) |

Verhinderung/Förderung der Externalitäten = Steuern / Subventionen

exakte Besteuerung sodass $E_{opt} = E^*$ = *Pigou-Steuer* 

- arbeitet nach Verursacherprinzip
- benötigt exakte Informationen



## Nutzungskonflikte

Beispiel: Stahlwerk mit Abwasser und Fischereidorf im Nutzungskonflikt

Modellierung:

- Stahlwerk mit Stahl *s* und Emissionen *x*
- Fischereibetrieb mit Produktion *f*



Gewinnfunktion des Stahlwerks:

- $G_s = p_s * s - c_s(s,x) \text{ mit } \frac{\partial c_s}{\partial x} < 0$
- d.h Vermeidungskosten von Emissionen (letzter Term)

Gewinnfunktion Fischerei

- $G_f = p_f * f - c_f(f,x) \text{ mit } \frac{\partial c_f}{\partial x} > 0$
- d.h Emissionsminderung führt zu steigender Produktion (letzter Term)

Zusammenfassung beider Unternehmen zu Konglomerat

$$
\begin{aligned}
G &= p_f * f + p_s * s - c_s(s,x) - c_f(f,x) \\

\frac{\partial G_s}{\partial s} &= p_s - \frac{\partial c_s}{\partial s} = 0 \to p_s = \frac{\partial c_s}{\partial s} \\

\frac{\partial G_s}{\partial f} &= p_f - \frac{\partial c_f}{\partial f} = 0 \to p_f = \frac{\partial c_f}{\partial s} \\

\frac{\partial G}{\partial x} &= \underbrace{- \frac{\partial c_s}{\partial x} - \frac{\partial c_f}{\partial x} = 0
}_{\text{Externer Effekt!}}
\end{aligned}
$$
Gesamtunternehmen müsste Grenzkosten der Fischerei als auch des Stahls berücksichtigen = *externer Effekt* wird internalisiert

Darstellung: 

- Grenzvermeidungskosten GVK = Grenzsozialkosten GSK
- für Stahlwerk optimale Emission $x^* > x_{opt}$
- Internalisierung => weniger Emissionen
- *US* = Umweltschutz

![2022-05-31_14.19.37](../images/2022-05-31_14.19.37.jpg)



### Pigou Steuer

mögliche Handlungsoption gegen Umweltverschmutzung

$$
G_s = p_s * s - c_s(s,x) - t*x \\
\implies p_s = \frac{\partial c_s}{\partial s} \text{ und } t =  - \frac{\partial c_s}{\partial x}
$$
Problem: mangelnde Information vorab über perfekten Steuersatz

### Emissionsrechte

Variante I: Fischerei erhält dRecht auf saubere Umwelt, verkaufbar gegen *q*
$$
G_s = p_s * s - c_s(s,x) - q*x \\
G_f = p_f * f - c_f(f,x) + q*x \\ 
p_s = \frac{\partial c_s}{\partial s} ;\ q = - \frac{\partial c_s}{\partial x} \\
p_f = \frac{\partial c_f}{\partial f} ;\ q = - \frac{\partial c_f}{\partial x} \\
$$
=> perfekter Internalisierung von Kosten

- oder Stahlwerk erhält Rechte
- auch genau gleiche Menge an Emission und Kosten
    - = **Coase-Theorem** (auch aus Einführung in VWL bekannt)
- distributive Auswirkung der Politik unterschiedlich, je nachdem wer Rechte erhält

Schlussfolgerung:

```
Staat sollte nicht eingreifen, sondern Rahmenbedingungen setzen (theoretisch). Alle Instrumente basieren jedoch auf der Annahme perfekter Informationslage der Grenzkosten für alle Beteiligten.

In Realität so selten gegeben, deswegen auch andere Instrumente sinnvoll, bspw. staatliche Mengenbegrenzungen etc.
```

## Auflagen und Abgaben

aufgrund von Informationsproblem Instrumente inzwischen auf politisch vorgegebenes Umweltziel fokussiert, statt "realer" gesellschaftlicher Kosten

Instrumente werden an 3 Kriterien gemessen:

- *ökologische Treffsicherheit:* lässt sich das Niveau punktgenau ansteuern?
- *Kosteneffizienz*
- *Innovationseffizienz*: Anreize für Fortschritt?



### Instrument I : Auflage

Maximal-**Auflage** für Firmen (Legal Base Line LBL)

![2022-05-31_14.51.48](../images/2022-05-31_14.51.48.jpg)

- hier: 2 Unternehmen mit unterschiedlichem Einsparpotenzial
    - Grenzvermeidungskosten = Marginal Abatement Cost MAC
- beide müssen in gleichem Maße zurückschneiden = Ineffizienz

### Instrument II: Abgabe

![2022-05-31_14.58.17](../images/2022-05-31_14.58.17.jpg)

- beide Unternehmen reduzierun um unterschiedliche Mengen
- regt zu Innovationen an
- bietet Einnahmequelle für Staat an = kosteneffizienter

### Intrument III: Cap + Zertifikatehandel

es wird Obergrenze (Cap festgelegt) und dann für die verbleibenden Emissionen Zertifikate  ausgeben + Handelsplatz

- ökologisch absolut treffsicher
- emissionsparende Firmen werden für Emission belohnt
- sehr kosteffizient
- Preis sortiert Unternehmen anhand als Einsparer oder Emittenten

![2022-05-31_15.06.57](../images/2022-05-31_15.06.57.jpg)





## Übung 12

### Negative Effekte und Besteuerung

Markt für privates Gut *x*

- nachfrage: $p = -3x+110$
- private Grenzkosten: $pMC = x+30$
- soziale Grenzkosten $sMC = x+70$

Bestimmung des Wettbewerbsgleichgewichts
$$
pMC = D \\
x+30 = -3x +110 \\
4x = 80 \to x = 20 \\
p = -3x*20+110 = 50
$$
mit gesellschaftlichen Grenzkosten
$$
x+70 = -3x+110 \\
x = 10 \to p = 80
$$

Optimum: soziale Grenzkosten = private Grenzkosten
$$
x+70 = x+30 + \underbrace{t}_{Steuer} \to \underline{t = 40}
$$
![2022-06-22_16.06.20](../images/2022-06-22_16.06.20.jpg)

### Positive Effekte und Subventionierung

Wettbewerblicher Markt mit positiven Effekten eines Gutes

- private Zahlungsbereitschaft sD: $p = -3x+110$
- soziale Zahlungsbereitschaft pD: $p = -3x+150$
- $MC = x+30$

Wettbewerbsgleichgewicht: x=20

gesellschaftliches Optimum: $x+30 = -3x+150 \to x = 30$

Subvention sodass *sD = pD*
$$
-3x+150 = -3x+110 + \bf{s} \\
s = 40
$$

Graphik: ![2022-06-22_16.06.36](../images/2022-06-22_16.06.36.jpg)


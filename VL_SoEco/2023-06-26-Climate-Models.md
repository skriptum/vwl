# 26.06.2023 Climate Models

## Geschichte der IAM

-   Nordhaus erstmals 1993 "Erfinder"
    -   DICE: Dynamic Integrated Climate and Economy
    -   Nobelpreis 2018 mit Paul Romer
    -   =\> 4°C optimal These
-   Stern dann in sehr beachteten Report für UK Gov, komplett andere Ergebnisse
-   Nobelpreis für Nordhaus 2018

## Allgemein

generelles Funktionieren von Klimamodellen

``` mermaid
graph LR
W(Wachstum) --mehr--> E(Emissionen) --mehr--> 
T(Temperaturanstieg) --mehr-->S(Schaden) --weniger zukünftiges--> W
```

Verbindung von Geographie, Physik und Ökonomie

-   für jeden Link einen Zusammenhang definieren
-   und daraus dann ein Optimierungsmodell

Ergebnis:

-   ein Social Cost of Carbon

> Heutige wert des zulünftigen Schadens einer emittierten Tonne co2

-   daran soll sich dann ein (weltweiter) CO2 Preis orientieren

## Kritik

### Damage Function

Nordhaus: quadratischer Zusammenhang
$$
L(T) = 1/ T^2
$$

- L = Loss (Damage)
- T = Temperaturanstieg 



-   eigentlich keinen seriöse Forschung
-   einfach nur vermutete Zusammenhänge

Problem:

-   Klimakippunkte kommen oft nicht vor (oder sind schwer modellierbar)
-   weil sie nicht modellierbar sind

### Discount Rate

$$
r = \rho + η g
$$

- Rho: Zeitpräfernez (heute lieber als morgen)
- Ng = mehr Wohlstnad in Zukunft = einfacherer Verzicht

Bild: Tausend Dollar in X Jahren kriegen, Wert heute

-   Idee: zukünftiger Wohlstand = weniger Wert als heutiger Wohlstand
-   also wird die Zukunft abdiskontiert

Problem:

-   nicht individuell, sondern intergenerationell
-   ist ethische Frage, sollte also vllt bei 0 liegen



**erzeugt =>**

### Anschein von Seriösität

-   das Label "Wissenschaftlich" gibt den Anschein von Wahrheit
    -   insbesondere ein "Nobelpreis"

mit diesen Modellen kann man sich seine Klimapolitik bauen, wie man will

Beispiel:

- Obama Adminstration: 43$ pro Tonne SCC (3% Discount Rate)
- Trump Administration: 3$ pro Tonne SCC (7% Discount Rate)



## Alternative

Fokus aus katastrophale Ergebnisse (in 50 Jahren)

-   Shcaden auf Wirtschaft und
-   Wahrscheinlichkeiten für diese bestimmen
-   dann erwarteter Nutzen berechnen für Verhindern dieser Ereignisse
-   benötigte Reduktion (T CO2), um diesen Punkt zu erreichen

=\> Social Cost of Carbon

mithilfe von Expertenmeinungen

## Diskussionfragen

-   Müssen Modelle einfach sein, damit Politiker:innen sie verstehen?
-   Sollten wir sie für pädagogische Zwecke nutzen?
-   verstellen sie uns den Blick auf alternative Klimapolitische Ansätze?
    -   wegen starker Fokussierung auf einen CO2 Preis



Refs:

Climate Solow: https://doi.org/10.1016/j.iree.2016.06.002

Nordhaus Original: https://doi.org/10.1016/0928-7655(93)90017-O

Pindyck Paper: https://doi.org/10.1093/reep/rew012

Stern Review: https://www.osti.gov/etdeweb/biblio/20838308
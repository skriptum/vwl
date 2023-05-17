# 20.11.2022 Verhaltensökonomik I

die Abweichungen von der rationalen Theorie: ![img](../images/2022-11-20_18-53-13.jpg)

## Opportunitätskosten

> **Opportunitätskosten:** implizite Kosten durch Nichtwählen der nächstbesten Alternative

**Realität**: der Mensch wählt nicht alles rational! (nimm das Mikroökonomik :fist_oncoming: )

**Problem**:

- alle Alternativen kennen
- ihr Nutzen bewerten möglich

## Sunk Costs

> **Sunk Costs**: bereits angefallene, irreversible Kosten.

- Spielen in Standardtheorie keine Rolle für Entscheidungen

Beispiel Kostenentscheidungen

```mermaid
graph LR
1((.)) --invest 1mio--> 2((Position))
1 --invest 0--> 3((Alternative))
2 --invest 1mio--> 4(Reward = 10) & 5(Reward  = 0)
3 --invest 1mio--> 6(Reward = 10) & 7(Reward  = 0)
```

an sich sollte diese Entscheidung zufällig sein an der Position, aber realisitisch wird sich immer für ersteres entschieden

=> *Sunk Cost Fallacy*

## Abhängigkeit von irrelevanten Alternativen

schlechtere Alternativen sollten keinen Einfluss haben auf Entscheidungen (*Decoy Effekt*)

> **Decoy Effekt:** wenn x aus Menge {x,y} ausgewählt, und das ist rational; dann y aus {x,y,z} ist irrational!



Realität; passiert, wenn man schlechtere Alternative hinzufügt, sieht anderes wie guter Deal aus

Beispiel: Abonnements des Economist

![img](../images/2022-11-20_19-27-16.jpg)

- Gruppe 1: Option Digital und Print
- Gruppe 2: alle 3 Optionen

Eigentlich sollte das gleiche sein in den Prozentzahlen von Option 1 und 3

=> durch schlechte Alternative wird andere Entscheidung gewählt

Erklärung: ![img](../images/2022-11-20_19-33-16.jpg)



## Endowment Effekt

> **Endowment Effekt:** Präferenzen über Alternativen hängen von Besitz des Individuums ab (seinem "Endowment")

- Präferenzen hängen ab von Referenzpunkt
- wir mögen unseren Besitz sehr = Verlustaversion

> **Verlustaversion:** Menschen leiden mehr, wenn sie etwas verlieren als wenn sie den gleichen Betrag bekommen

Beispiel: Geld oder Lottoticket

Merke: der Gegenstand, den man besitzt ist nicht an sich attraktiver, nur Aufgeben ist schwieriger



## Verlustaversion im Modell

### Wertfunktion

- zentrales Element der Prospekt Theorie
- modelliert Nutzen oder Wert von Änderungen der Ausstattungen
- Eigenschaft: Verlust = höherer Rückgang als Gewinn

![img](../../../../../Desktop/screenshots/2022-11-20_22-31-03.jpg)

Beispieldefinition:
$$
v(x) = 
\begin{cases}
x/2&for\  x\geq 0\text{ (gains)}\\
2x&for \ x < 0 \text{ (losses)}
\end{cases}
$$
=> Referenzpunkt ist wichtig für Bewertung

Beduetung für Mirko:

- Indifferenzkurve ist unumkehrbar
- IDKs können Knick haben (abhängig von Referenzpunkt)

### in der Realität

- Aktienmärkte
    - verkaufen zu früh bei steigenden Preisen
    - und zu spät bei Verlusten (um nicht zu realisieren)
- Immobilinemärkte
    - Weiderverkaufspreis hängt ab von Original-Kaufpreis
- Arbeitnehmer- Lohntabellen



Feldexperimente:

- Arbeitnehmer in China
- zwei Bezahlungssysteme
    - Gehalt + Abzug bei geringer Produktivität
    - Gehalt + Bonus bei hoher Prod.
- erste Situation = besser



## Übung

### Aufgabe 1: Entscheidungsbaum

a) Entscheidungsbaum mit Erträgen

```mermaid
graph LR
1(Entscheidung) --1500--> Aktien 
1 --650--> Anleihen 
1 --2200--> Immobilien
```

b) Opportunitätskosten 

höchste Nutzen der nächstbesten Alternative

NUtzenfunktion: $u(x) = x$

```
Aktein: 2200
Immo: 1500
Anleihen: 2200
```

### Aufgabe 3: Decoy

der perfekte Wingman und der Decoy-Effekt 

Skala 1-10 bei Intelligenz + Attraktivität

- **Sucher**: I=5, A=5
- Person 2: I=4, A=6
- Person 3: I=7, A=3

wie muss der Wingman ausgestattet sein?

- muss in beiden Dimensionen schlechter sein als mann selbst
- aber die Konkurrenz in einer Dimension schlagen

Beispielsweise I=4.1; A=3.1

### Aufgabe 4: Verlustaversion

$$
v(x) = \begin{cases}x/3&x\ge0\\ 3x&x<0\end{cases} 
$$

zwei personen besitzen Aktie:

- Preis gestern = 7
- Preis heute = 4



Person 1: ursprünglicher Preis als Referenzpunkt

- gestern= 0m, heute = -3
- Nutzenfunktion: $v(0)-v(-3) = 0- (-3 \cdot 3) = -9$ Nutzen verloren

**=> Auffasung als Verlust**

Person 2: heutiger Preis als Referenzpunkt

- Heute = 0
- Gestern = +3
- Nutzenfunktion: $v(0)-v(+3) = 0-(\frac{1}{3}3)= -1$ Nutzen verloren

 **=> Auffassung als verlorener "Gewinn"** (weil nicht gestern verkauft)

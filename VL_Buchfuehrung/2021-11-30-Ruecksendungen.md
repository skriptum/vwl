# 30.11.2021 Rücksendungen + Nachlässe



## Rücksendungen

(Video 17)

> **Rücksendungen:** entweder an Lieferanten oder von Kunden aufgrund von Mängeln

Ansprüche aufgrund von Mängeln:

- entweder Reperatur
- Austausch durch Neuprodukt
- wenn keine 2 Reparaturen oder keine Neulieferung:
    - Rücktritt vom Vertrag
    - Preisminderung

In Deutschland 2 Jahre Gewährleistungsdauer



### Buchung von Rücksendungen

`Rücksendungen sind wie Rückbuchungen!`

Beachten: Steuerberichtigung, Wertminderung



#### an Lieferanten

Beispiel: 

1. Einkauf von Rohstoffen auf Ziel (6000,-)
2. Rücksendung eines Teils der Leistung (900,-)

zu 1:

```
200 Rohstoffe             | 6000,-
260 Vorsteuer             | 600,-
an 44 Verbindlichkeiten   | 6600,-
```

zu 2: (**einfach Buchungssatz umdrehen**)

```
44 Verbindlichkeiten      | 990,-
an 200 Rohstoffe.         | 900,-
an 260 Vorsteuer          | 90,-
```



---

#### von Kunden

1. Verkauf von Fertigerzeugnissen auf Ziel (12.000€)
2. Beanstandung und Rücksendung eines Teils vom Kunden (3000€)

zu 1:

```
240 Forderungen       | 13 200,-
an 500 Umsatzerlöse   | 12 000,-
an 480 Umsatzsteuer   | 1 200,-
```

zu 2:

```
500 Umsatzerlöse      | 3000,-
480 Umsatzsteuer      | 300,-
an 240 Forderungen    | 3300,-
```



- [x] **Übung 7.4!**



## Nachlässe

> **Nachlass:** Preisminderung aufgrund von Mängelrügen 



### im Einkauf

entweder als Netto- oder Bruttobuchung 

Beispiel: *wir erhalten vom Lieferanten Preisnachlass von 20% auf Rohstofflieferung (5000,-)*

```
Rohstoffpreis netto:       5000,-
   davon 20% Nettonachlass = 1000,-
+ Vorsteuer                500,-
   20% Steuerberichtigung  = 100,-
------------------------------------------
= Rechnungspreis (brutto)  5500,-
   Nachlass                = 1100,- 
```

Unterkonten :

- 200**2** Nachlässe für Rohstoffe
- 202**2** Nachlässe Hilfsstoffe
- ...

#### Standardbuchung

```haskell
1) einkaufsbuchung
200 Rohstoffe               | 5 000,-
260 Vorsteuer               | 500,-
an 44 Verbindlichkeiten     | 5 500,-
2) nettobuchung des nachlasses (20%)
44 Verbindlichkeiten        | 1 100,-
an 2002 Nachlässe Rohstoffe | 1 000,-
an 260 Vorsteuer            | 100,-
3) am monatsende: umbuchung der nachlässe
2002 Nachlässe Rohstoffe    | 1000,-
an 200 Rohstoffe            | 1000,-
```

---

(Video 18)

### im Verkauf

dem Kunden gewährte Preiserlässe sind **Erlösschmälerungen** und müssen somit gebucht werden 

Konten:

- 5001: Erlösberichtigungen (Fertigerzeugnisse)
- 5101: Erlösberichtigungen (Handelswaren)

Abschluss über Hauptkonten 500 / 510

#### Standardbuchung

Beispiel: Gewährung 20% Nachlass auf einen 7000,- Nettoverkauf

```
1) Verkauf
240 Forderungen          7 700,-
an 500 Umsatzerlöse      7 000,-
an 480 USt               700,-
2) Nachlass 20%
5001 Erlösberichtigung   1 400,- (20% von 7k)
480 Ust                  140,-
an Forderungen           1 540,-
3) Abschluss des Unterkontos
500 Umsatzerlöse         1400,-
an 5001 Erlösbericht.    1400,-
```



### Skonto

> **Skonto:** Preisminderung bei Zahlung innerhalb vereinbarter kürzerer Frist (vorgezogen) und dann 2% Nachlass

quasi Zinsbelohnung für frühere Zahlung



#### Lieferantenskonto

= Minderung der Anschaffungskosten 

Bsp: 2200,- Lieferanteneinkauf mit 2% Skonto

```
Rohstoffpreis 2000,- 
   minus 2% Skonto 40,-
+ Vorsteuer 200,-
   minus 2% Skonto 4,-
---------------------------
Rechnungsbetrag 2200,-
   minus Skonto gesamt 44,-
= 2156,-
```



Standardbuchung: (bei Zahlung) 

```
44 Verbindlichkeiten          2200,-
an 2002 Nachlässe für Rohst.  40,-
an 260 Vorsteuer              4,-
an 280 Bank                   2156,-
```



#### Kundenskonto

= Schmälerung der Umsatzerlöse

Bsp: Banküberweisung von einem Kunden für 1100€ (brutto) abzüglich 2% Skonto 

```
Nettopreis      1000,-
  -2% Skonto    20,-
+ Umsatzsteuer  100,-
  -2% Skonto    2,-
----------------------
Rechnungsbetrag 1 100,-
  -2% Skonto    22,-
= 1078,-
```

Buchung:

```
280 Bank              1078,-
5001 Erlösbericht.    20,-
480 Umsatzsteuer      2,-
an 240 Forderungen    1100,-
```



**Übungen**

- [ ] 7.7
- [ ] 7.8


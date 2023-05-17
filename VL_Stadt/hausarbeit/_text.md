

## I: Modellspezifikation

Distrikte aus Zensus für Regressionsmodell

- Wachstum des Anteils der Stadt am Distrikt i, Land j, Jahr t
- auf durchschnittliche Feuchtigkeit
- Zeininvariante Kontrollen
- länderspezifische Fixed Effects
    - um Ländertrends auszusortieren

- Fehlerterm nach Distrikt sortiert

=> Frage: Was passiert, wenn die Feuchtigkeit zurückgeht?


## Ergebnisse

- 1. Zeile interessant

1. Spalte: Einfluss auf alle Städte
    - generell negativ : sinkende Feuchtigkeit -> höheres Wachstum
    - nicht statistisch signifikant
2. Spalte: Einfluss auf Städte mit moderner Industrie
    - negativer Zusammenhang
    - statistisch signifikant
    - sinkt Feuchtigkeit -> Erhöht Stadtwachstum
3. Spalte: Städte mit Industrie gesamt
    - ähnlich Spalte 2, aber stärker

Betrachtung: 

=> durchschnittliches historisches Sinken der Feuchtigkeit von 0.44% pro Jahr
=> bedeutet für meist industrialisierte Distrikte: Erhöhung Stadtwachstum 0.51%

---

graphische Veranschaulichung: 

Zusammenhang zw. Feuchtigkeit und Anzahl Industrien in Distrikt

inkl 95% Knfidenzintervalle

---

## Robustheitskontrollen:

- Konflikt
    - kann auch ausgelöst durch schlechte Erträge Landwirtschaft
    - aber nicht evident
- Entfernung zur Küste
    - hat Einfluss auf Niederschlag
    - da aber nicht mit Industriestandord korreliert
        - keine Evidenz

```
je stärker eine Stadt industrialisiert, desto stärker wächst sie bei Niederschlagsreduktion
```

---

## II: Modellspezifikation

Methodik:

- Städte mit Lichtdaten und ihrem Umkreis von 30km. (*outer envelope*)
- kombiniert mit Niederschlagsdaten 



Spezifikation der Regression

- Log. Lichtindex der Stadt *i*, im Jahr *t*
- auf Niederschlag gemittelt über 3 Jahre
- zeitinvariante Kontrollen
- Fixed Effects für Stadt und Jahr
- stadtspezifischer linearer Trend

hier: Fluktuation des Lichts jahr zu Jahr als Ergebnis des Niederschlags der Stadt / umkreis 

---

## Ergebnisse

1. Spalte Effekt auf alle Städte
    - generell negativ
    - aber nicht statistisch signifikant, da heterogenität
2. Spalte: Städte mit moderner Industrie
    - negativer Zusammenhang
    - statistisch signifikant
    - Senkung Niederschlagsmenge => niedrigere Lichtemissionen 

Zahlen abstrak,: hier Beispiel

- Erhöhung der Niederschalgsmenge um Standardabweichung
- => reduziert Lichtemissionen um 11%, Einkommen um 3.5%

```
je stärker eine Stadt industrialisiert, desto stärker wächst ihr Einkommen bei Niederschlagsreduktion
```



**Robustness Checkks**

- gegen Fluten: 
    - viel Wasser und verringert Einkommen
    - keinen signifikanten Effekt
- Städte mit Wasserkraft Energieversorger
    - geringe Strompreise => Einfluss auf Lichtintensität
    - keine Evidenz

---

## Ergebnisse 

nochmal Zusammenfassung:

- Afrika wird vom Klimawandel stark getroffen
- Klimawandel wird Menschen in die Städte treiben
- nur industrialisierte Städte profitieren insgesamt



#### Bewertung des Papers:

positiv:

- Forschung über gesamtafrikanischer Kontext
    - bisher nur einzelne Länder
- Datenquelle für Industriestandorte wegweisend (Atlas von 1965)
    - guter Indikator in Region mit wenigen einheitlichen Daten

Negativ:

- Verbindung beider Forschungsfragen schwierig
    - unterschiedliche Datensätze aus unterschiedlichen Zeiträumen
    - einmal 50 Jahre, einmal 30 Jahre
    - Unterschiedlich: Distrikt, Stadt
- Unsicherheit für Datenquelle Zensus
    - starke Unterschiede in Qualität, 
    - aber viele Checks der Autoren

---
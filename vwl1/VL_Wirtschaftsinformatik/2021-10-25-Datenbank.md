# 25.10.21 Datenbanken

### Datenbanksystem

> **Datenbanksystem**: besteht aus
>
> - Datenbank
> - Datenbankmanagementsystem (DBMS)

Besteht aus Dateien mit *logischer Abhängigkeit* (relationale Datenbank)

DBMS:

- Verwaltung nach Regeln
- Zugriffsmöglichkeit
- Sicherheit

> **Datei:** gleichartige und logische Datensätze

mit Datensätzen aus Datenelementen gleichen Aufbaus

bekannte Datenbanken: OracleDB, PostreSQL, ...



Merkmale von DBMS:

- Verwaltung nach Regeln
- gleichzeitiger Zugriff
- Integrität und Sicherheit



> **Transaktion:** Zusammenfassung einzelner logischer Datenbankoperiationen

Transaktionsystem arbeitet nach *ACID*-System:

- *Atomacity*: Transaktion entweder vollständig oder gar nicht ausgeführt
- *Consistency*: DB nach Trans. Wieder konsistent
- *Isolation*: Zwischenergebnisse sind für andere unsichtbar
- *Durability:* Fehlerabsicherung



## Relationelles Modell

Basis für viele moderne DBS

Datenbank = eine / meherere *verküpfte* Tabellen

### Modellierung

Jeder Zeile wird *eindeutige Kennziffer* zugeordnet (**Primärschlüssel**)

Beispiel Kundentabelle

| Kundennr. (Primärschlüssel) | Name    | PLZ   |
| --------------------------- | ------- | ----- |
| 1                           | Meier   | 33100 |
| 2                           | Meoulli | 30203 |

Kennziffer wird in anderer Tabelle wieder benutzt als **Fremdschlüssel**

Bestellungstabelle

| Bestellungsnr (primär) | Kundennr. (fremd) | Datum    |
| ---------------------- | ----------------- | -------- |
| 1                      | 56                | 12.10.45 |

> **Schlüssel**: dienen eindeutigen Identifikation und schneller Suche (durch Indizierung)
>
> Primär-, Fremd- und Sekundärschlüssel (alternativer Suchschlüssel)



Vorteile: 

- Intuitiv und strukturiert
- einfache Speicherung

> **Superschlüssel**: Datenattribute, die ausreichen, alle anderen zu beschreiben

### SQL

einfache Datenbanksprache

- Beispiel: alle Waren mit Warentyp T
- =\> *SELECT* *  *FROM* Ware *WHERE* Warentyp = 'T'

**Syntax**: Befehle immer in CAPS

- Auch über mehrere Tabellennmit JOIN

Beispiel:

```
SELECT Kunde.Vorname, Kunde."Name"
FROM Bestellung, Kunde
WHERE Bestellung.BestellNr>"4"
AND Bestellung.KundenNr=Kunde.KundenNr
```






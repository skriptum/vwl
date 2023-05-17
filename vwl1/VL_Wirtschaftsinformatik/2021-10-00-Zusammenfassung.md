# Wirtschaftsinformatik

### Übersicht

1. [Allgemein](#allgemein)
    - [Daten](#daten)
2. [Datenbanken](#datenbanksystem)
    - [relationelles Modell](#relationelles-modell)
    - [Entity-Relationship-Modell](#entity-relationship-modell)
3. [Geschäftsprozessmanagement](#geschäftsprozessmanagement)
    - [Modellierung mit EPK](#modellierung-mit-epk)
    - [Modellierung mit ARIS](#modellierung-mit-aris)
    - [Prozessoptimierung](#prozessoptimierung)
4. [Anwendungsysteme](#anwendungssysteme-aws)
    - [Informationssysteme](#informationssystem)
    - [Innerbetriebliche AW-Systeme](#innerbetriebliche-awsysteme)
    - [Unternehmensübergreifende AW-Systeme](#unternehmensübergreifende-aws)
5. [UML-Diagramme](#uml)
    - [Klassendiagramm](#klassendiagramm)
    - [Use-Case-Diagramm](#use-case-diagramm)
6. [Softwarentwicklung](#Überlappendes-phasenmodell) 

## Allgemein

> **Wirtschaftsinformatik:** Konzeption, Einführung, Wartung, Nutzung von computergestützten Informationssystemen in Betrieben

- Bedeutung zunehmen durch Wichtigkeit von Daten in heutigen Unternehmen
- mehr als reine Computerprogramme, sondern im soziotechnischen System von Mensch => Maschine => Aufgabe

### Daten

> Zeichen, die aufgrund von Vereinbarungen Informationen enthalten

| Hierarchie der Daten | Beispiel               |
| -------------------- | ---------------------- |
| 1. Zeichen           | 11                     |
| 2. Daten             | 11 Grad                |
| 3. Information       | 11 Grad = kalt         |
| 4. Wissen            | kalt = Jacke mitnehmen |

- codiert mit Bits / Bytes
- verarbeitet mit *Programmen*
- organisert in *Dateien*

> **Programm:** in *Programmiersprache* formulierter *Algorithmus*

> **Algorithmus:** definierte Handlungsvorschrift zur Problemlösung

> **Programmiersprache:** Sprache mit Syntax (Regeln) und Semantik (Bedeutung) zur Implementierung von Algorithmen in computerveständlicher Weise

> **Datei:** komplexer Datentyp für dauerhafte Speicherung von Informationen

Speicherung in **Datenbanken!**

# Datenbanksystem

System aus *Datenbankmanagementsystem* und *Datenbank*

| Datenbankmanagementsystem (DBMS)       | Datenbank                                  |
| -------------------------------------- | ------------------------------------------ |
| System zur Datenverwaltung und Zugriff | mehrere verknüpfte Tabellen                |
| Regelbasiert (Syntax)                  | in relationellem Modell                    |
| sicher (mit Zugriffsrechten)           | Vorteil: intuitiv + einfache Speicherung   |
| Beispiele: MySQL, SQLite,...           | Darstellung mit Entity-Relationship-Modell |

## relationelles Modell

Ansammlung von Tabellen, die mithilfe von Schlüsseln verbunden werden

- bestehend aus Relation (Tabelle) mit Attributen (Spalten) nach einem Schema
- Beispiel: ![22-02-07_14-56](../images/22-02-07_14-56.jpg)

um diese Tabellen auf einheitliches System zu bringen : **Normalisierung** in mehreren Stufen für minimale Redundanz an Daten

Ausganstabelle: ![22-02-07_15-11](../images/22-02-07_15-11.jpg)

### 1. Normalform

| Vorgang                   | Anwendung                                              |
| ------------------------- | ------------------------------------------------------ |
| Primärschlüssel festlegen | CD_ID = Primärschlüssel                                |
| Felder atomatiseren       | Album => Künstler und Album, Titelliste wird erweitert |

![22-02-07_15-13](../images/22-02-07_15-13.jpg)

### 2. Normalform

> **(funktionelle) Abhängigkeit:** wenn ein Attribut immer durch ein anderes Attribut bestimmt wird, ist es abhängig von ihm

Beispiel:

- Vorname ist abhängig von Matrikelnummer, da jeder Matrikelnummer = ein Name $Name \to MNr$
- Matrikelnummer ist **nicht** abhängig von Name, da es auch Namen gibt, die sich doppeln

| Vorgehen                                                   | Anwendung                                        |
| ---------------------------------------------------------- | ------------------------------------------------ |
| keine Nichtschlüsselattribute abhängig von Primärschlüssel | Auslagern von Tracks und Titel in eigene Tabelle |

![22-02-07_15-15](../images/22-02-07_15-15.jpg)

### 3. Normalform

| Vorgehen                                                 | Anwendung                                                    |
| -------------------------------------------------------- | ------------------------------------------------------------ |
| jegliche NSA, die von anderen NSA abhängig sind auslagen | Interpret und Gründungsjahr sind abhängig => auslagern in Tabelle |

![22-02-07_16-31](../images/22-02-07_16-31.jpg)

## Entity-Relationship-Modell

- Modell zur Beschreibung der Systematik einer Datenbank

Bestandteile:

- bestehend aus *Entitäten* mit *Attributen* (Eigenschaften), dabei jeweils ein Primärschlüssel
- Menge aus allen Entitäten eines Types ist *Entitätsmenge*
- Entitäten sind verbunden mit *Relations* (Beziehungen), wobei in der Verbindung die jeweiligen Primärschlüssel angegeben werden
    - können Kardinalitäten haben (1:1, 1:n, n:m)

![22-02-07_14-22](../images/22-02-07_14-22.png)

Umwandlungsregeln zu einer Datenbank:

- jeder Entitätstyp eigene Tabelle
- n:m Kardinalität mithilfe eigener Tabelle darstellen
- 1:n Kardinalität: in Tabelle des n-Typs den Primärschlüssel des 1-Typs

# Geschäftsprozessmanagement

> **GPM:** Strategie der prozessorientierten Unternehmensführung

> **Geschäftsprozess:** inhaltlich abgeschlossene Folge von Aktivitäten zur Bearbeitung einer Aufgabe

Vorteile:

- schnelle Anpussung / Änderung von Workflows
- Qualitätsteigerung

Ebenen von GPs:

- Strategisch: *welche Leistung?* 
- Taktisch: *wie Leistung erstellen?*
- Operativ: *wie umsetzen?*

Ziele: 

- Kundenausrichtung
- Flexibilität

Umsetzung mit *Geschäftsprozessmodellierung* 

> **GPM:** Identifikation, Analyse, Gestaltung von Geschäftsprozessen

## Modellierung mit EPK

> **EPK:** Ereignisgesteuerte Prozessketten, Modellierungsprache

Bestandteile

| Ereignis                                                  | Funktion                                                  | Konnektor                                                 |
| --------------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------------------- |
| ![2022-02-07_17.09.55](../images/2022-02-07_17.09.55.jpg) | ![2022-02-07_17.09.52](../images/2022-02-07_17.09.52.jpg) | ![2022-02-07_17.10.05](../images/2022-02-07_17.10.05.jpg) |
| passive Komponente                                        | aktive Komponente                                         | verbindende Komponente                                    |
| Substantiv + Partizip (Rechnung erstellt)                 | Substantiv + Partizip (Rechnung bearbeiten)               |                                                           |

Konnektoren:

- AND: wenn alle Ereignisse eintreten / Funktionen bearbeitet wurden => Funktion/Ereignis auslösen

    - ```mermaid
        graph TD
        1{{Notizen zusammengefasst}}
        2{{Probeklausur erledigt}}
        3{{Kommilitonen genervt}}
        1 & 2 & 3 --> 4((AND)) --> 5[Klausur verkacken]
        ```

- OR: wenn mind. eine Funktion ausgeführt wird => Ereignis auslösen

- XOR: wenn genau ein Funktion ausgeführt wird =>Ereignis  auslösen

Regeln:

- Beginn / Ende mit Ereignis
- kein Objekt ohne Verbindung
- pro Element nur eine Verbindung (außer Konnektoren)
- Wechsel Ereignis | Funktion
- Ereignisse können keine OR/XOR auslösen, da kein Entscheidungscharakter

Verfeinerung: Unter-EPK zur genaueren Darstellung einer Funktion

### Erweiterte EPK (eEPK) 

erweitert EPK um Objekte, die an Funktionen angefügt werden können

| Organisationseinheit                                      | Dokument                                                  | Datenbank                                                 | Anwendungssystem (wie Excel)                              |
| --------------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------------------- |
| ![2022-02-07_18.03.50](../images/2022-02-07_18.03.50.jpg) | ![2022-02-07_18.03.56](../images/2022-02-07_18.03.56.jpg) | ![2022-02-07_18.04.01](../images/2022-02-07_18.04.01.jpg) | ![2022-02-07_18.04.07](../images/2022-02-07_18.04.07.jpg) |

Beispiel für eEPK![22-02-07_18-16](../images/22-02-07_18-16.png)

## Modellierung mit ARIS

- ***Ar**chitektur integrierter **I**nformations**S**ysteme*
- Architekturmodell für Erweiterung der EPK
- bestehend aus 5 Schichten

![21-11-19_13-25](../images/21-11-19_13-25.jpg)

| Sicht        | Inhalt                                                | Darstellung    |
| ------------ | ----------------------------------------------------- | -------------- |
| Organisation | alle Ressourcen / Einheiten                           | Organigramm    |
| Daten        | Datenbetreffende Ereignisse / Objekte                 | ERM            |
| Steuerung    | zeitlich logischer Plan und Verknüpfung aller Sichten | EPK            |
| Funktion     | Modell aller verfügbaren Funktionen                   | Funktionsliste |
| Leistung     | Modell der Bestandteile einer Leitung                 | Baumdiagramm   |

Leistungssicht Beispiel:![2022-02-08_11.33.53](../images/2022-02-08_11.33.53.jpg)



## Prozessoptimierung

Ziele:

- Kostensenkung
- Zeitersparnis
- Transparenz

2 Arten:

| Art                                 | Stärke                          | Ausführend                     | Zeitrahmen                |
| ----------------------------------- | ------------------------------- | ------------------------------ | ------------------------- |
| **Process Reengineering**           | große weitgreifende Veränderung | von Geschäftsleitung ausgehend | schlagartig implementiert |
| **Continous Process Optimitsation** | kleine Schritte                 | von Mitarbeitern ausgehend     | kontinuerlich             |

### Prozessautomatisierung

- Erleichterung von Aufgaben
- für Prozesse mit geringer Intensität und hohem Wiederholgsgrad
- mithilfe eines *Workflowmanagementsystems*

> **WFMS**: System zur Automatisierung von Prozessen; Fokussierung auf Logistik der Datenweitergabe (bspw. automatisches Weiterleiten von Daten / Aufträgen,...)



# Anwendungssysteme AWS

## Informationssystem

> **IS:** soziotechnisches Systeme zur Bereistellung von Information + Kommunikation

- zur Effizienzsteigerung
- schnelle Iteration neuer Produkte

![2022-02-07_19.20.37](../images/2022-02-07_19.20.37.jpg)

## AW-Systeme

> **AWS:** Softwaresystem zur Durchführung von Aufgaben in unterschiedlichen Unternehmensbereichen

Ziele:

- Unterstützung betrieblicher Anwendungen
- Lösung von fachlichen Problemen (bspw. Lohnkalkulation)

Daten in AWS:

- in zentraler Datenbank gespeichert
- um Redundanzen zu vermeiden
- systematisiert nach:
    - Veränderbarkeit : *Stammdaten | Bewegungsdaten*
    - Darstellung: *grafisch | alphanumerisch*
    - Zeitbezug: *historisch | aktuell*

### Innerbetriebliche AWSysteme

![22-01-13_20-25](../images/22-01-13_20-25.jpg)

> **Enterprise Resource Planing System (ERP)**: integriertes betriebswirtschaftliches Softwarepaket 

- erlaubt Organisationen von Geschäftsprozessen in allen Abteilungen
- modulare Teilsysteme mit gemeinsamer Datenbasis

Bestandteile (Module):

- Personalsystem
- Vertriebssystem
- Finanzanwendung
- Produktionsplanungssystem

Risiko:

- Abhängig von einem Anbieter
- Verlust der Unternehmenseigenheiten da vorgefertigtes Paket

### Unternehmensübergreifende AWS

![22-01-13_20-16](../images/22-01-13_20-16.jpg)

> **Supply-Chain-Management (SCM):** System zur Planung, Durchführung, Steuerung des Material / Informationsflusses zwischen Unternehmen

Ziele:

- enge Zusammenarbeit
- Abschaffung Friktion
- optimaler Materialfluss
- Verhinderung *Peitscheneffekt*

> **Peitscheneffekt**: verzögerte Informations-Weitergabe von Bestellmengen führen zu extremen Schwankungen beim Hersteller 

Arten der Integration:

1. Teilen der Auftragsinformation
    - simple Weitergabe der Bestellmenge
2. Teilen der Nachfrageinformation
    - Echtzeit-Datenweiterleitung der Nachfrage
3. Vendor-Managed-Inventory
    - Lieferant bekommt vollständigen Zugriff auf Lager + Daten
    - im Gegenzug vollständiges Retourenrecht



# UML

> **Unified Modelling Language:** standardisierte Sprache zur Beschreibung von Softwarekonzepten / systemen

- viele verschiedene Arten von Diagrammen, am wichtigsten das Klassendiagramm

## Klassendiagramm

> **Klasse:** Objekttyp, der Struktur von Objekten darstellt

Instanzen der Klasse = Objekte

bestehen aus:

- Eigenschaften (Attribute) mit Typ, bspw: `flugmeilen : integer`
- Operationen (Methoden), bspw: `meilenGutschreiben()`

| Darstellung                                     | Beschreibung                                                 |
| ----------------------------------------------- | ------------------------------------------------------------ |
| ![21-11-29_16-32](../images/21-11-29_16-32.jpg) | Kopfzeile: Klassenname<br/>Mitte: Attribute<br/>Unten: Methoden |



### Beziehungen zwischen Klassen

| Beziehungstyp                | Beschreibung                                                 | Bild                                            |
| ---------------------------- | ------------------------------------------------------------ | ----------------------------------------------- |
| Assoziation                  | eine Beziehung zwischen zwei Klassen, dargestellt durch *Linie* | ![21-11-29_16-36](../images/21-11-29_16-36.jpg) |
| Assoziation mit Beschreibung | Bezeichnung für Assoziation mit schwarzem Dreieck als Leserichtung | ![21-11-29_16-38](../images/21-11-29_16-38.jpg) |
| Multiplizitäten              | Bezeichnug, wie viele Objekte sich auf Quellobjekt beziehen  | ![21-11-29_16-40](../images/21-11-29_16-40.jpg) |
| Rolle                        | kennzeichnet Rolle, die Objekt für anderes spielt            | ![21-11-29_17-08](../images/21-11-29_17-08.jpg) |
| Aggregation                  | spezielle Form: "ist Teil von"                               | ![21-11-29_17-11](../images/21-11-29_17-11.jpg) |
| Komposition                  | Form der Aggregation, nur wenn Quellobjekt existiert         | siehe oben ↑                                    |
| Vererbung+ Generalisierung   | Objekt ist Untergruppe eines anderen Objekts                 | ![21-11-29_17-31](../images/21-11-29_17-31.jpg) |

Beispiel:

![22-02-08_10-02](../images/22-02-08_10-02.png)

## Use-Case-Diagramm

weiterer wichtiger Diagrammtyp

![22-02-08_10-17](../images/22-02-08_10-17.png)

Verbindungen im Use-Case-Diagram:

- **Erweiterung** <<extend\>\> : optionale Ausführung 
    - Optional bei Abhebung: nach 3 Versuchen Konfsizierung
- **Unteranwendung** <<includes\>\> : notwendige Bedingung
    - Geldabhebung benötigt Authentifizierung der Karte
- **Verallgemeinerung** (Vererbung ) = Unterklasse eines Typs

---

# Überlappendes Phasenmodell

Modell zur Entwicklung von Software

![2022-02-08_10.48.20](../images/2022-02-08_10.48.20.jpg)

| Phase                   | Ziel                             | Verantwortlicher                   | Tätigkeiten                                         | Dokumente                                      |
| ----------------------- | -------------------------------- | ---------------------------------- | --------------------------------------------------- | ---------------------------------------------- |
| *I. Vorstudie*          | Entscheidung über Durchführung   | Interne / externe Berater          | Projektziele, Rahmenbedingungen, Aufwand bestimmen  | Machbarkeitstudie                              |
| *II. Ist Analyse*       | Feststellung des Zustands        | Organisationsentwickler            | Systemerhebung + Potenzialanylse                    | Systembeschreibung mit Schwachstellen          |
| *III. Sollkonzept*      | Festlegung Soll-Zustandes        | Organisationsentwickler            | Redesign Abläufe, neuer Aufbau, Empfehlung Software | Organisationsplan + Kostenvoranschlag Software |
| *IV. Systementwurf*     | Festlegung der Systemarchitektur | Softwareentwickler                 | Entwurf Benutzeroberfläche + Funktionen             | Systementwurf                                  |
| *V. Implementierung*    | Erstellung des Systems           | Softwareentwickler                 | Entwurf, Code, Tests!                               | Code, Testfälle, Dokumentation                 |
| *VI. System-Einführung* | Umstellung auf neues System      | Organisations + Softwareentwickler | Schulung, Installation, Betreuung                   | Abschlussbericht                               |


# 17.11.2021 Normalisierung Übung

> **Normalisierung:** Prozess der Vereinfachung und Entzerrung von Datenbanken (schrittweiser Prozess)

bei Normalisierung werden nur Redundanzen reduziert, es gehen keine Infos verloren

Beispiel Ausgangstabelle

![21-11-17_08-58](../images/21-11-17_08-58.jpg)

### 1.Normalform

- alle Attributwerte atomar (Bsp: Name + Vorname getrennte Spalten)
- Primärschlüssel wurden festgelegt
- frei von Wiederholungen

Beispiel: alle Doppelungen werden atomarisiert, und ein weiterer Primärschlüssel wird festgelegt

![21-11-17_08-59](../images/21-11-17_08-59.jpg)

### 2. Normalform

> **2\. Nornalform**: (Relation) wenn kein Nichtschlüsselattribut von einem Teil des Primärschlüssels abhängig ist

- alles in 1.NF
- Relationen in 2. Normalform

Also: alles was irgendwie von einem Primärschlüssel abhängig ist, eigene Tabelle

**Beispiel**: alles was von einem Primärschlüssel abhängt wird ausgelagert 

![21-11-17_09-03](../images/21-11-17_09-03.jpg)

### 3. Normalform

> **3\. Normalform**: kein Nichtschlüsselattribut ist nur von einem anderen abhängig

- alles in 2. NF
- Relationen in 3. NF

**Beispiel:** alles was von einem Nichtschlüsselattribut abhängt, wird auch ausgelagert (Punkte -> Note)

![21-11-17_09-04](../images/21-11-17_09-04.jpg)

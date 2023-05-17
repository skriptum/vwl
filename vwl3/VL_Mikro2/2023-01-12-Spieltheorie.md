# 12.01.2023 Spieltheorie I

*bisher*: Ergebnis hängt nur von individuellen Ergebnissen ab

*jetzt*: abhängig von anderen Menschen (**strategische Komponente**)

- erwartete Handeln des Anderen wird einbezogen
- Erwartung bilden über dieses Handeln
- Modellierung dieser komplexen Entscheidungssituation = *Spieltheorie*



## Begriffe

> **Spiel**: Entscheidungssituation, bei der das Ergebnis von der Entscheidung mind. eins anderen Agenten abhängt

- **Agenten** = Spieler
- **Strategie** = Handlungsplan für alle möglichen Situationen
- **Auszahlungsmatrix** = Auszahlungen für alle möglichen Kombinationen von Strategien
- **Strategieprofil** = Vektor mit einer Strategie pro Spieler
- **Koordinationsspiel** = Spiel mit höchster Auszahlung bei Kooperation



**Beispiel**: Zwei Schüler schwindeln, dass ihnen ein Platten geplatzt ist. Sie müssen in Nachholklausur getrennt voneinander sagen, welcher es wahr.

- *Strategien*: *Vorne links VL, VR, HL, HR,*
- *Strategieprofil*: 
    - *<VL,VL>* = 100, 100
    - *<VL,VR>* = 5, 5

*Auszahlungsmatrix*:

- :x: = Klausur verkackt: Auszahlung 5 Punkte
- :white_check_mark: = Klausur bestanden: Auszahlung 100 Punkte

| Spieler 1/2 | VL                 | VR                 | HL                 | HR                 |
| ----------- | ------------------ | ------------------ | ------------------ | ------------------ |
| **VL**      | :white_check_mark: | :x:                | :x:                | :x:                |
| **VR**      | :x:                | :white_check_mark: | :x:                | :x:                |
| **HL**      | :x:                | :x:                | :white_check_mark: | :x:                |
| **HR**      | :x:                | :x:                | :x:                | :white_check_mark: |



## Nash-Gleichgewicht

> **Nash-GG:** Strategieprofil, in dem die Strategien der Spieler wechselseitig beste Antworten aufeinander sind

- *in reine Strategien:* Nash-GG = jeder spielt eine beste Strategie
- *in gemischten Strategien*: Spieler spielen mit verschiedenen Wahrscheinlichkeiten Strategien



nash-Frage: gibt es eine Strategieprofil mit Besserstellung beider?

## Arten von Spielen

**Koordinationsspiel mit gemeinsamen Interessen:**

- alle Spieler bevorzugen das selbe GG

| Spieler $1 \downarrow / \ 2 \to$ | fußball | Theater |
| -------------------------------- | ------- | ------- |
| **Fußball**                      | 3,3     | 0,0     |
| **Theater**                      | 0,0     | 1,1     |

beide wollen lieber Fußball schauen



**Koordniationsspiel mit Interessenskonflikt:**

- verschiedene Spieler bevorzugen unterschiedliche GG

![img](../images/2023-01-19_13-30-53.jpg)

ein Spieler lieber Fußball, der andere lieber Theater



**Nullsummenspiel:**

- das was einer gewinnt
- verliert der andere



## Wichtige Konzepte

- **dominante Strategie**
    - Strategie, die unabhängig von anderem Spieler beste Wahl ist
    - "Egal, was der andre macht, ich mach das"
- **dominierte Strategie**
    - wenns eine dominante gibt, sind alle anderen dominiert
- Nash-GG findet man durch Eliminerung aller dominierten Strategien
- **pareto-Verbesserung:** wenn alle Spieler ein Ergebnis bevorzugen
    - alle verbessern sich oder bleiben mindestens gleich
    - niemand wird schlechtergestellt
- **pareto-optimal:** Ergebnis, dass nicht mehr pareto-verbesserungsfähig ist



## Gefangenendilemma

Situation mit Konflitk zwischem *kollektivem Interesse* und *Eigeninteresse*

- zwei Bankräuber werden erwischt, man kann aber fast ncihts nachweisen
- beide Spieler sitzen in unterschiedlichen Räumen
- Optionen: *Gestehen, Nicht Gestehen*
    - je nachdem Jahre im Gefängnis Strafe

Auszahlungsmatrix

| Gefangener A/B     | Nicht gestehen | Gestehen |
| ------------------ | -------------- | -------- |
| **Nicht Gestehen** | 2, 2           | 1, 20    |
| **Gestehen**       | 1, 20          | 10, 10   |

Interpretation:

- wenn einer Kronzeuge ist, dann geht er weniger ein als wenn alle die Fresse halten (1 < 2)
- wenn beide 31er sind, dann ist das schlecht (10 > 2)
- **Pareto-optimal**: keiner gesteht
- **Nash-GG**: beide gestehen
    - dominante Strategie beider ist gestehen
    - und sie sind beide letztendlich schlechter gestellt

**=> seid [keine 31er](https://www.youtube.com/watch?v=tFZaD9W0kDk), redet nicht mit Cops!**

![2023-01-19_13-30-55](../images/2023-01-19_13-30-55.png)

*Anna und Arthur haltens Maul, und du?*

### Lösungen

Vereinbarung

- vorab getroffene Vereinbarung (talk is cheap) leicht auffindbar
- deswegen mit Konsequenzen (Kopfgeldjäger in Falle des Gestehens)

Wiederholte Zusammenarbeit

- Spiel öfter durchführen
    - wenn unendlich oft wiederholt = Strategie ändert sich
    - endlihc oft wiederholte = keine Strategieänderung weil *Rückwärtsindikation*



**Rückwärtsindikation:** 

- wie entscheiden Spieler in letzter Runde? 
- und wie ich dann in vorletzter?
- und wie dann der andere in vor-vor-letzter
- am Ende keine Zukunft = keine Strategieänderung


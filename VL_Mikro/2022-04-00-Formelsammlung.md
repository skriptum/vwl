# Formelsammlung

## Haushalte

- Nutzenfunktion $U(x_1,x_2) = x_1^a x_2^b$ (oder ähnlich)
- IDK: Nutzenfunktion nach $x_2$ umstellen
    - MRS $= \frac{MU_x}{MU_y}$
        - subjektives Substitutionswollen
        - Steigung der IDK
        - Ableitung der Nutzenfunktion nach x/y
    

- Budgetgerade: $B = p_1 x_1+p_2 x_2$
    - MRT = $-\frac{p_1}{p_2}$
        - objektives Substitutionskönnen
        - Steigung: $x_2 = -\frac{p_1}{p_2} x_1 + \frac{B}{p_2}$
- Gleichgewicht: $MRS =MRT$
- Elastizität der Nachfrage: $\epsilon_{x,p}= \frac{\Delta x \%}{\Delta p \%} = \frac{\Delta x / x}{\Delta p / p}$ , *dimensionslos*
    - $\epsilon = 0$: vollkommen elastisch
    - $0 < \epsilon < 1$ relativ unelastisch
    - $ 1 \le \epsilon < \infty$: relativ elastisch
- Auch: Einkommenselastizität: $\frac{\Delta x / x}{\Delta B / B}$

## Unternehmen

- **Gewinn** = Erlös - Kosten: $G(x) = E(x) - C(x)$
- Isoquatenfunktion = Produktionsfunktion zweier Inputs $x(r_1,r_2)$
    - Steigung: MRTS = $\frac{\Delta r_2}{\Delta r_1} \bigg|_T = -\frac{\frac{\partial x}{\partial r_1}}{\frac{\partial x}{\partial r_2}}$
    - technisches Substitutionskönnen

- Kostenfunktion: $C = q_1 * r_1 + q_2 * r_2$
    - Kapital + Arbeit: $C = wL+qK$
    - Funktionsumstellung: $K = -\frac{w}{q}L+\frac{C}{q}$
    - MRMS = $-\frac{q_1}{q_2}$

Optimum: mithilfe der Lagrangefunktion $L = wL+qK + \lambda (x-L^a K^b)$

- Kosten $C = C_V + C_F$
    - Durchschnitsskosten :$\frac{C}{x} = \frac{C_v}{x} + \frac{C_F}{x}$
    - $\frac{C}{x}$ = *Average Total Cost*
    - $\frac{C_V}{x}$ = *Average Variable Cost*
    - $\frac{C_F}{x}$ = *average Fixed Cost*

langfristiges Angebot: $p = ATC_{min}$

kurzfrisitges Angebot: $p = MC$

- Grenzkosten $MC = \frac{\partial C}{\partial x}$ 
- $ATC_{min}: \frac{\partial ATC}{\partial x} = 0$
- gewinnoptimale Outputmenge: Umstellen von p=MC

Vertikaladdition von Supply: $x_m = x_1+x_2$ (umstellen der Angebotsfunktion nach x)

## Märkte

### Gütermarkt

- MRS = MRT
- Konsumentenrente = $\frac{(Reservationspreis-Marktpreis) \cdot Menge}{2}$
- Produzentenrente = $\frac{(Marktpreis-Reservationspreis) \cdot Menge}{2}$

### Arbeitsmarkt

- Einkommen $I = w \cdot t_A$ (Lohn mal Abreitszeit) 

- Wertgrenzprodukt Arbeit $WGP_A = p \cdot \frac{\partial x(L,K)}{\partial L}$
    - Beitrag des letzten eingestellten Mitarbeiters = *Grenzvorteil*
    - Grenznachteil = Lohnkosten
- Optimum: $w = WGP_A$

### Kapitalmarkt

Budgetbeschränkung

- gegenwärtige Wert zukünftiger Auszahlungen $B = \frac{m}{(1+r)^t}$
    - *m* = heutige Einzahlung
    - *r* = Zins
- Intertemporal: Budget Aufteilung auf ein Gut in zwei Perioden
    - $x_{p2}, x_{p1}$ = Güter in Periode 1/2
    - $m_1,m_2$ = Einkommen in Periode 1 / 2
    - Preise der Güter sind konstant und gleich 1
    - Budget in Zukunftswerten: $\overbrace{(1+r) * m_1 + m_2}^{\text{Budget}} = \overbrace{(1+r) * x_{p1} + x_{p2}}^{\text{Ausgaben}}$
    - B in Gegenwartswerten: $\underbrace{m_1 + \frac{m_2}{(1+r)}}_{\text{Budget}} = \underbrace{x_{p1} + \frac{x_{p2}}{(1+r)}}_{\text{Ausgaben}}$
- Güterkonsum in Periode 2: $x_{p2} = m_2 + (1+r)*(m_1-x_{p1})$
- intertemporalen Budgetgerade: $x_2 = -MRT \cdot x_1 + IPO$ 
    - MRT: $- (1+r)$
    - Schnitt Y-achse (IPO) = $m_1 \cdot (1+r) + m_2$
    - Schnitt X-achse (IPA)= $m_1+ \frac{m_2}{(1+r)}$

Optimierung mithilfe $L = U(x_{p1}, x_{p2}) + \lambda \ [m_1 * (1+r) + m_2 - (1+r)x_{p1} - x_{p2}]$

- Zeitpräferenzrate Tau  $\tau = \frac{MU(x_{p1})- MU(x_{p2})}{MU(x_{p2})} = r$ Zinssatz 

### Verscicherungsmarkt

Risiko

- Mögliche Wahrscheinlichkeitsverteilung einer Entscheidung $W = [\underbrace{s_1,...,s_n}_{\text{Ereignisse}}\; , \underbrace{\pi_1, ...,\pi_n}_{\text{Wahrscheinlichkeiten}}]$
- Erwarteter Nutzen: $EU = U(s_1) \cdot \pi_1 + U(s_2) \cdot \pi_2 + ...$
- Erwartungswert: $EV = s_1 \cdot \pi_1 + s_2 \cdot \pi_2 + ...$
- Entscheidend für Risikoverhalten: $U(EV) \neq EU$
    - $U(EV) = EU$: risikoneutral
    - $U(EV) > EU$: risikoavers
    - $U(EV) < EU$: risikoneutral
        - Nutzen der sicheren Alternative < Nutzen der unsicheren Alternative

Versicherungen

- $y^*$ = Einkommen / yield
- L = Loss / Verlust
- Versicherungsprämie: $P =p \cdot q$
    - p = Versicherungssatz (in Prozent)
    - q = Versicherungssumme

| Outcomes       | keinen Schaden | Schaden             |
| -------------- | -------------- | ------------------- |
| **ohne Vers.** | $y^*$          | $y^* -L$            |
| **mit Vers.**  | $y^*- (p*q)$   | $y^* - L+q - (p*q)$ |

- $y_b$ = Einkommen im Schadensfall
- $y_g$ = Einkommen im Fall ohne Schaden



- $EU = U(y_g) \cdot (1-\pi) + U(y_b) \cdot \pi$
- $EV = y_g \cdot (1-\pi) + y_b \cdot \pi$
- Indifferenzkurve eines Punktes P: $EU_P = EU$ gleichsetzen und nach $y_b$ umstellen
    - BSP: $8 = 0.4 y_g^{0.5} + 0.6 y_b^{0.5}$  für Punkt mit EV=8 und Nutzenfunktion $U=y^{0.5}$ 
    - => $y_b = (20-1,5y_g^{0.5})^2$
- Budgetgerade: $y_b = -MRT \ y_g + SPO$
    - $MRT =\frac{1-p}{p}$ Substitutionskönnen zwischen $y_b$ und $y_g$ 
        - Aufgeben von einem Euro -> Schadensfall $\frac{1-p}{p}$ Euro mehr

    - $SPO = \frac{y^*}{p}L$ 
        - = Alles geld wird in Versicherung gesteckt

- Substitutionswollen: $- \frac{1-\pi}{\pi} * \frac{\frac{\partial U}{\partial y_g}}{\frac{\partial U}{\partial y_b}} = MRS$

Optimiere mit Lagrange: $max U(y_g,y_b)$  s.t  $y_b = y_g+125$

im Optimum: $MRS = MRT \to \frac{1-\pi}{\pi} * \frac{MU_{y_g}}{MU_{y_g}} = \frac{1-p}{p}$

- bei fairer Prämie $p = \pi$: Haushalt wählt Vollversicherung
- bei unfairer Prämie $p > \pi$: Haushalt wählt Unterversicherung
- Bei gönnerhafter $p < \pi$: Haushalt überversichert



## Monopole

- Gewinnoptimum: $Grenzkosten = Grenzerloese$

    - Erlöse(x): $p(x) \cdot x$  = (PAF * x)
    - Grenzerlöse = $\frac{\partial E}{\partial x} = \frac{\partial p(x) \cdot x}{\partial x}$
- Mengenfixierung: $G(x) = p(X) * X - K(X)$
    - $$
      \frac{\partial G}{\partial X} = 
      \underbrace{\frac{\partial p}{\partial X} * X}_{T_1} +
      \underbrace{p* \frac{\partial X}{\partial X}}_{T_2} - 
      \underbrace{\frac{\partial K}{\partial X} }_{T_3}
      = 0 \text{  mit } \frac{\partial X}{\partial X} = 1  \\
      \to T_1 + T_2 - T_3 = 0
      $$
- Preisfixierung: $G(p) = p \cdot X(p) - K(X\small(p) \big)$
- Amoroso Robinson Fomel:  $p = \frac{\overbrace{\frac{\partial K}{\partial X}}^{MC} }{ 1- \frac{1}{|\varepsilon_{x,p|}}}$
    - je niedriger Elastizität => höhere Monopolpreisaufschlag
    - wenn Elastizität unendlich; Monopolpreis = Grenzkosten = Polypolbedingung
    - umgestellt nach $\epsilon = \frac{1}{1- \frac{MC}{p}}$


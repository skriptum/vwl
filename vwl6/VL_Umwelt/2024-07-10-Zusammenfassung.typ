// Some definitions presupposed by pandoc's typst output.
#let blockquote(body) = [
  #set text( size: 0.92em )
  #block(inset: (left: 1.5em, top: 0.2em, bottom: 0.2em))[#body]
]

#let horizontalrule = [
  #line(start: (25%,0%), end: (75%,0%))
]

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms: it => {
  it.children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
      ])
    .join()
}

// Some quarto-specific definitions.

#show raw.where(block: true): block.with(
    fill: luma(230), 
    width: 100%, 
    inset: 8pt, 
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let d = (:)
  let fields = old_block.fields()
  fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.amount
  }
  return block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == "string" {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == "content" {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

#show figure: it => {
  if type(it.kind) != "string" {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let old_title = old_title_block.body.body.children.at(2)

  // TODO use custom separator if available
  let new_title = if empty(old_title) {
    [#kind #it.counter.display()]
  } else {
    [#kind #it.counter.display(): #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block, 
    block_with_new_content(
      old_title_block.body, 
      old_title_block.body.body.children.at(0) +
      old_title_block.body.body.children.at(1) +
      new_title))

  block_with_new_content(old_callout,
    new_title_block +
    old_callout.body.children.at(1))
}

#show ref: it => locate(loc => {
  let target = query(it.target, loc).first()
  if it.at("supplement", default: none) == none {
    it
    return
  }

  let sup = it.supplement.text.matches(regex("^45127368-afa1-446a-820f-fc64c546b2c5%(.*)")).at(0, default: none)
  if sup != none {
    let parent_id = sup.captures.first()
    let parent_figure = query(label(parent_id), loc).first()
    let parent_location = parent_figure.location()

    let counters = numbering(
      parent_figure.at("numbering"), 
      ..parent_figure.at("counter").at(parent_location))
      
    let subcounter = numbering(
      target.at("numbering"),
      ..target.at("counter").at(target.location()))
    
    // NOTE there's a nonbreaking space in the block below
    link(target.location(), [#parent_figure.at("supplement") #counters#subcounter])
  } else {
    it
  }
})

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color, 
        width: 100%, 
        inset: 8pt)[#text(icon_color, weight: 900)[#icon] #title]) +
      block(
        inset: 1pt, 
        width: 100%, 
        block(fill: white, width: 100%, inset: 8pt, body)))
}



#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  if title != none {
    align(center)[#block(inset: 2em)[
      #text(weight: "bold", size: 1.5em)[#title]
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(center)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
#show: doc => article(
  title: [Umweltökonomik],
  toc_title: [Table of contents],
  toc_depth: 3,
  cols: 1,
  doc,
)


= Allgemein
<allgemein>
Umwelt \= knappes Gut \=\> braucht Ökonomik

- umweltrelevantes menschliches Verhalten
- Opportunitätskosten von Umweltschutz
- Zielkonflikte

== Knappheit
<knappheit>
- relative Knappheit:
  - Vorhandensein von Alternativen \(Subsitution)
  - Preise \= Maß der rel. Knappheit
- absolute Knappheit
  - nicht subsituierbar
  - keine \(sinnvollen) Preise
  - Bsp.: stabiles Klimasystem

Darstellung

#figure([
#box(width: 651.0pt, image("../images/2024-07-10_10-59-411.jpg"))
], caption: figure.caption(
position: bottom, 
[
img
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


== Externalitäten
<externalitäten>
#quote(block: true)[
#strong[Externalität:] nicht durch Verträge erfasste "Nebeneffekte" wirtschaftliche Handels
]

- positiv / negativ
- Gesellschaftliche Kosten $eq.not$ soziale Kosten

\=\> braucht Internalisierung

Problem: viele Umweltgüter \= #strong[öffentliche Güter]

- nicht handelbar \=\> kein marktpreis
- andere Lösungsansätze, sonst #emph[Tragedy of the Commons \(Hardin)]

dezentrale Governance nach #strong[Elinor Ostrom];, braucht:

- klar definierte Grenzen
- Überwachung
- Sanktionsmöglichkiten
- Konfliktlösungsmechanismen
- Anerkennung durch Regierung

Umweltschutz \= Prinzipal-Agenten-Problem; Informationsasymmetrie zw.

- Prinzipal \(Staat, Gesellschaft)
- Agent \(Landwirt:in, Förster:in)

#quote(block: true)[
#strong[Informationsasymmetrie];: ungleiche Verteilung von Informationen zw. Vertragspartnern
]

- ex-ante: vor Vertrag \=\> #emph[adverse Selektion]
- Ex-post: nach Vertrag \=\> #emph[moral hazard]

== Gefangenendilemma
<gefangenendilemma>
soziales Dilemma: rationales Verhalten \=\> suboptimales Ergebnis

#figure(
align(center)[#table(
  columns: 3,
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: 6pt,
  [Gefangener A/B], [Nicht gestehen], [Gestehen],
  [#strong[Nicht Gestehen];],
  [2, 2],
  [1, 20],
  [#strong[Gestehen];],
  [1, 20],
  [10, 10],
)]
)

Lösungsansötze:

- Mafia-Omerta: Druck von außen, nicht zu gestehen
- Mehrmalige Wiederholung \(tit-for-tat)

= Sozial-ökologische Systeme
<sozial-ökologische-systeme>
#quote(block: true)[
#strong[sozial-ökologische Systeme];: komplexe Systeme mit zwei Teilsystem \(Sozial & Ökologisch)
]

== Eigenschaften
<eigenschaften>
+ Emergenz
+ rückkoppelung
+ Resilienz & Kipppunkte
+ Heterogenität

#horizontalrule

#quote(block: true)[
#strong[Emergenz:] Mikroverhalten + Interaktion \=\> Makrophänomen
]

geht einher mit:

- nicht lineare Effekte
- Kipppunkte

Beispiel: Schellings Wohnraumsortierung

#horizontalrule

#quote(block: true)[
#strong[Rückkopplung];: Bidirektionale Beziehungen zw. Systemkomponenten
]

- positiv oder negativ
- verstärkend / schwächend

Beispiel: $Delta T arrow.r.double.long E i s s c h m e l z e arrow.r.double.long A l b e d o arrow.b arrow.r.double.long + Delta T$​

#horizontalrule

#quote(block: true)[
#strong[Kipppunkte:] Systempunkte, an denen ein System zusammenbricht, die nicht linear abschätzbar sind
]

Beispiel: Klimakipppunkte

Modellierung auf #link("https://netlogoweb.org/launch")[Netlogo];, siehe #emph[Fire] Beispiel

#horizontalrule

#quote(block: true)[
#strong[Resilienz];: capacity of system to absord bisturbance rend retain essentially the same function, structure and identity
]

Bsp.: Monowälder im Harz \= nich resilient

Bsp. 2: QWERTY-Lock IN

#horizontalrule

Effekte in sozial-ökologischen Systemen

- #strong[Verlagerungseffekt]
  - Lokale Reduktion in Umweltbelastung
  - \=\> Preisverschiebung
  - \=\> Ausgleich anderswo
- #strong[Reboundeffekt]
  - Effizienzsteigerung
  - \=\> Reduktion in Umweltbelastung & Preis
  - \=\> höhere Nachfrage durch niedrigeren Preis

== Relevanz von SES
<relevanz-von-ses>
normale VWL: #strong[problematische Annahmen]

- mur lineare Zusammenhänge
- repräsentative Agenten \(statt emergentes Verhalten)
- nur Partial-Analyse, nicht Gesamtzusammenhänge

\=\> begrenzte Aussagekraft

= Naturkapital
<naturkapital>
#quote(block: true)[
#strong[Naturkapital];: Bestandsgröße der natürlichen Produktionsfaktoren
]

- wächst nach!
- Bestandsgröße

```mermaid
graph LR
Investitionen-->![(Naturkapital)]-->Ökosystemleistungen
```

#quote(block: true)[
#strong[Ökosystemleistungen];: Direkte / indifrekte Beiträge von ökosystemen zu menschlichem Wohlergehen
]

- weit gefasster Begriff
- antropozentrische Perspektive
- an Nutzen für Menschen gebunden

#figure([
#box(width: 664.0pt, image("../images/2024-07-10_12-29-55.jpg"))
], caption: figure.caption(
position: bottom, 
[
img
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


Kategorien von Ökosystemleistungen

- Versorgung
- Regulierung
- Kulturelle

Beispiele für Ökosyatemleistungen

- Nahrungsmittelproduktion
- Landschaftsästhetik
- …

== Arten der Nachhaltigkeit
<arten-der-nachhaltigkeit>
schwache Nachhaltigkeit \= Substituierbarkeit

Starke Nachhaltigkeit \= wenig Substituierbarkeit

- kritisches Naturkapital
- absolut notwendig
- teil des fairen Vermächtnisses für die nächste Generation
  - Notwendige \(stabiles Klima)
  - Nützliche \(Forst)
  - Außergewöhnliche \(Lüneburger Heide)

= Bewertung
<bewertung>
Methoden der ökonomischen Bewertung

- Kostenbasierte Methoden
- Produktionsfunktion
- Offenbarte Präferenzen
- Geäußerte Präferenzen

== Wert
<wert>
#quote(block: true)[
#strong[Wert] \= Einheit einer entscheidungsrelevanter Größe, meist Geld
]

beachte: #strong[Tauschwert vs.~Nutzwert] \(Diamanten vs Wasser)

ökonomischer Wert

- relative Knappheit
- Präferenzen
- Substitiuerbarkeit
- Subjektivität

Bestandteile

#figure([
#box(width: 656.0pt, image("../images/2024-05-13_14-30-35.jpg"))
], caption: figure.caption(
position: bottom, 
[
img
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


== Kostenbasierte Methoden
<kostenbasierte-methoden>
Grundidee: Kosten einer Maßnahme \= Proxy für Wert

Beispiele:

- Vermeidungskosten
- Opportunitätskosten
- Ersatzkosten \(Flutmauer statt Aue)

Vorteil: wenig Aufwand

Nachteil: nur selektiv anwendbar, keine Informationen über Präf.

== Produktionsfunktion
<produktionsfunktion>
Formulierung einer Produktionsfunktion für auf Märkten gehandeltes Gut

#figure([
#box(width: 652.0pt, image("../images/2024-05-13_14-34-51.jpg"))
], caption: figure.caption(
position: bottom, 
[
img
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


Kalkulation des Beitrags der Erde / Biene zu Endprodukt

Nachteil: aufwendig, nur für nutzungsabhängige Werte

== offenbarte Präferenzen
<offenbarte-präferenzen>
Grundidee: Entscheidungen auf Märkten mit Umweltgütern

- auf Nachfrageseite
- mit statistischen Methoden

#strong[Reisekostenmethode]

Reiseausgaben zu Nationalparks \= Bereitschaft für NAturgut zu zahlen

#strong[Hedonische Bewertung];: Beiträge zu Immobilien / Bodenpreisen

Vorteile: Präferenzen aus tatsächjlichen Entscheidungen

Nachteile:

- nur für bestimmte ÖSL
- hoher Aufwand
- existierende Marktverzerrung

== geäußerte Präferenzen
<geäußerte-präferenzen>
Grundidee: direkte Befragung nach Präferenzen \(mit Fragebögen)

Varianten:

- #strong[Kontingente Bewertung:] #emph[Wie viel wären sie bereit zu zahlen für X]
- #strong[Choice Experimente:] Auswahl zwischen verschiedenen Szenarien
- #strong[Deliberative Methode];: Erweitung der Befragung
  - mit Gruppendiskussionen
  - für komplexe Umweltgüter

Vorteile: alle ÖSL, keine Verzerrugnen

Nachteile: Hypothetisch, aufwendig

== Diskontierung
<diskontierung>
Vergelich von Kosten / Nutzen zu unterschiedlichen Zeitpunkten

- Diskontrate \(p): Wertverlust von zukünftigen Zahlungsstrom
- Diskontfaktor \(ß): Kehrwert von Diskontrate
- Barwert \(BW): abdiskontierter Wert

Individuelle vs soziale Diskontrate \= #strong[unterschiedlich!]

- für künftige Generationen \(intergenerationelle Ethik)
- Aussterbe Wahrscheinlichkeit \(Long Tail)

Ramsey Formel: für #emph[soziale Diskontrate]

$ p = underbrace(delta, Z e i t p r ä f e r e n z) + underbrace(n, E i n k o m m e n s e l a s t .) \* underbrace(g, W a c h s t u m s r a t e) $

verschiedene Annahmen:

- g \= BIP? Trend in die Zukunft?
- d \= welche Güter, wie ermitteln?

\=\> #strong[Social Cost of Carbon]

- ökonomischer Wert einer vermiedenen Tonne CO2eq
- mithilfe von Integrated Assessment Model

== Kosten-Nutzen Analyse
<kosten-nutzen-analyse>
Grundidee: Gegenüberstellung von Kosten - Nutzen

- Vergleich von 2 oder mehr Optionen
- Option mit größten Nettonutzen wählen
- Statische Analyse

Arten

- Qualitative KNA
- Monetäre KNA

Beispiel: Autobahnbau in Stadt Halle

= Umweltrelevantes Verhalten
<umweltrelevantes-verhalten>
Problem: Leute wollen sich umweltfreundlich verhalten, aber tun es dann in der Realität nicht \(Bewusstsein $eq.not$ Verhalten)

Warum?

- Falsche Informationen \= teilweise
- Unterkomplexe Darstellung
- Individualismus

== Heuristics and Biases
<heuristics-and-biases>
Arten der begrenzten Rationaliät \(Daumenregeln etc.)

- #strong[Ankerheuristik] \= Orientierung an bekannten Zahlen
- #strong[Verfügbarkeitsheuristik] \= Ereignisse an die man sich leicht erinnert -\> gefühlt häufiger
- #strong[Repräsentativitätsheuristik]
- #strong[Verlustaversion] \= 100€ verlieren \= mehr Nutzenverlust als 100€ gewinnen

== Relative Motivation
<relative-motivation>
nach #emph[Amartya Sen]

- Altruistische Präferenzen:
  - Sympathy: eigener Nutzen beinhaltet anderen Nutzen
  - Commitment: Misery von anderen Menschen ablenken ohne eigenen Nutzen
- Meta Präferenzen: Präferenzordnung, die von aktueller Präferenz abweicht
  - Bsp.: Raucher, die eigentlich nicht rauchen wollen

Veblen: Conspicous Consumption

- konsum von Status Gütern
- Protzen
- verwand mit Positionale Güter \(Fred Hirsch)

== Sozial eingebettetes Verhalten
<sozial-eingebettetes-verhalten>
Bordieu:

- Habitus
- Kulturelles Kapital \=\> Symbolisches Kapital \=\> Sozialkapital
- Soziale Identität

Luhmann:

- Systemlogiken
- Hermetische Systeme

Diffusion von Innovation

== Motivation
<motivation>
individuelle Handlung \= vielschrittiger Prozess

- begrenzt von vielen Faktoren \(Gesellschaft, Geld, etc)
- soziale Dilemmata erschweren Handeln

```mermaid
graph 
subgraph Handlungspielraum
Z(Problemerkennung) --> A(Identifizierung der Lösung) --> B(Implementierung) --> C(Verinnerlichung kontin)
end
a[[soziale Barrieren]] -.-> Handlungspielraum
b[[ökonomische Barrieren]] -.-> Handlungspielraum
c[[regulatorische Barrieren]] -.-> Handlungspielraum
d[[technologiusche Barrieren]] -.-> Handlungspielraum
```

\=\> kollektives Handeln in Institutionen benötigt!

- bspw. soziale Norme / Rechte / Steuern
- Insbesondere großskalige Probleme

= Externalitäten
<externalitäten-1>
#quote(block: true)[
#strong[Externalitäten];: Auseinanderfallen von privaten | gesellschaftlichem Nutzen
]

Lösung: Steuern / Subventionen

Probleme: Information über soziale Kosten, Transaktionskosten

Ansätze zur Internalisierung:

- #strong[Pigou];: Steuer
  - Ansatz: gesellschaftl. Kosten \= private Kosten -\> Internalisierung
  - Problem: Information über soziale Kosten
- #strong[Coase];: Verhandlungen
  - Ansatz: bilatere Verhandlungen über Nutzungskonflikt
  - Problem: Transaktionskosten, Durchsetzung
- #strong[Ostrom];: dezentrale Governance
- #strong[Baumol] / Oates: Standard-Preis-Ansatz \(bspw. Emissionshandel)
  - Festlegen eines Standards \(bspw. Emissionshöchstmenge)
  - Preisbildung auf Märkten \(bspw. Zertifikate)

== Prinzipien der Umweltpolitik
<prinzipien-der-umweltpolitik>
#quote(block: true)[
#strong[Vorsorgeprinzip:] Vermeidung von Umweltgefahren über akute Gefahr hinaus
]

Voraussetzung:

- begründete Gefahrvermutung
- Unsicherheit
- Strategie zur Reduzierung

#quote(block: true)[
#strong[Verursacherprinzip];: Internalisierung beim Verursacher \(meist Gerechtigkeitsgründe)
]

Probleme:

- wer ist Verursacher \(Nutzungskonflikte)
- mehr als zwei Seiten bei Umweltproblem
- Internationale Regulierung?!

== Umweltpolitik
<umweltpolitik>
#figure([
#box(width: 627.0pt, image("../images/2024-06-19_13-19-22.jpg"))
], caption: figure.caption(
position: bottom, 
[
img
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


wie geht gute Politik?

- #strong[Ziel] adäquanz
- #strong[Instrument] Adäquanz
- #strong[Behaviorale] Adäquanz
- #strong[Objekt] Adäquanz

=== Instrumente
<instrumente>
- Ordnungsrecht \= Verbote / Gebote
  - Quoten
  - Emissionsttandards \(absolut / relativ)
  - Technologiestandards
- Anreize \(positiv / negativ)
  - Lenkungsteuern
  - Emissionshandel \(cap & trade)
  - Subventionen
- sonstige "weiche" Instrumente
  - Beschafffung
  - Siegel
  - Nudges

Lenkungsteuern:

#figure([
#box(width: 834.0pt, image("../images/2024-07-10_14-09-15.jpg"))
], caption: figure.caption(
position: bottom, 
[
img
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)


Analyse von Instrumenten

#figure(
align(center)[#table(
  columns: 4,
  align: (col, row) => (auto,auto,auto,auto,).at(col),
  inset: 6pt,
  [Kriterium], [Emissionsstandard], [Steuer / Subvention], [Zertifikate],
  [#emph[Wirksamkeit];],
  [+],
  [+],
  [+],
  [#emph[Wirkungsgeschwindigkeit];],
  [-],
  [++],
  [+\(+)],
  [#emph[Statische Effizienz];],
  [-],
  [+],
  [+],
  [#emph[Dynamische Anreizwirkung];],
  [-],
  [++],
  [+],
)]
)

Statische Effizienz \= niedrigste mögliche Kosten

dynamische Effizienz \= gute Anreize für umweltfreundliche Innovation

kontextabhängig \=\> #strong[Policy Mix]

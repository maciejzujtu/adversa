#import "@preview/algorithmic:1.0.7": *
#import "@preview/minimal-note:0.10.0": *
#import "@preview/mousse-notes:1.0.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let FONT   = "New Computer Modern" 
#let SIZE   = 12pt        
#let INDENT = 1.4em

#let chapter = [Rozdział]
#let def = [Definicja]
#let thm = [Twierdzenie]
#let lem = [Lemat]
#let exp = [Przykład]
#let exr = [Zadanie]
#let sol = [Rozwiązanie]
#let prf = [Dowód]
#let rmk = [Uwaga]

#let ABBREVIATIONS = (
  (def, "Def."),
  (thm, "Tw."),
  (lem, "Lem."),
  (exp, "Np."),
  (exr, "Zad."),
  (sol, "Roz."),
  (prf, "Do."),
  (rmk, "Uw.")
)

#let Adversa(
  title: none, 
  author: none,
  subtitle: none,
  outline-title: none,
  show-date: false,
  body
) = {

  set text(font: FONT, size: SIZE, fill: rgb("#1A1A1A"))
  set par(first-line-indent: INDENT, justify: true)
  set terms(hanging-indent: INDENT)
  set enum(indent: INDENT, numbering: "1.")
  set list(indent: 0.25em, marker: [#text(size: 1.1em, [*#sym.tilde*])])
  set document(author: if author != none { author } else { () }, title: title)
  set heading(numbering: "1.")
  set page(fill: rgb("#FDFBF7"), margin: (left: 12%, right: 12%))  

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(weight: "regular", hyphenate: false)
    set par(first-line-indent: 0em)
    block(
      inset: (left: -0.2em),
      height: 15% - 1em,
      {
        set text(size: 2em, spacing: 0.5em)
        (emph(it.body))
      } 
      + if it.outlined {
        emph[
          #v(0.9em, weak: true)
          #smallcaps[#chapter] #counter(heading).display()
        ]
      }
    )
    v(6em, weak: true)
  }
  show heading.where(level: 2): it => {
    block(
      sticky: true,
      (
        emph(text(size: 0.8em, counter(heading).display()))
        + h(0.5em)
        + emph(text(size: 1.05em, it.body))
        + box(
            width: 1fr, 
            align(
              right, line(
                length: 100% - 0.8em, start: (0%, -0.225em), 
                stroke: (
                  paint: black,
                  cap: "round",
                )
              )
            )
          )
      )
    )
    v(2em, weak: true)
  }
  show heading.where(level: 3): it => {
    block(
      sticky: true,
      (
        if it.supplement != auto { smallcaps(text(size: 1.15em, it.supplement + " ")) }
        + text(size: 1.08em, counter(heading).display())
        + h(0.5em)
        + emph(text(weight: "thin", it.body))
      )
    )
    v(1.5em, weak: true)
  }
  show outline.entry.where(level: 3): it => {
    let supplement = it.element.supplement
    if supplement != auto {
      let match = ABBREVIATIONS.find(pair => pair.at(0) == supplement)
      let name = if match != none { match.at(1) } else { "" }
      let prefix = [#name #it.prefix()]
      link(it.element.location())[
        #text(size: 0.95em, it.indented(none, prefix + h(0.3em) + it.inner()))
      ]
    } 
    else { it }
  }

  page[ // Title page styling
    #place(horizon + center, dy: -15%)[
      #set par(spacing: 0.7em, leading: 0.2em, justify: false)
      #align(center)[
        #if title != none [
          #text(size: 4em, smallcaps(title), weight: "regular", hyphenate: false)
          #v(2.5%, weak: true)
        ]
        #if subtitle != none [
          #text(size: 2em, smallcaps(subtitle))
          #v(2.5%, weak: true)
        ]
      ]
    ]
    
    #if author != none [
      #align(bottom + center, text(size: 1.5em, smallcaps(author)))
    ]

    #if show-date == true [
      #align(bottom+center, text(size: 1.2em)[
        #smallcaps(datetime.today().display("[day] [month repr:long] [year]"))
      ])
    ]
  ]
  
  // Contents
  outline(title: outline-title)
  pagebreak()
  
  set page(
    height: auto,
    footer: context [
      #place(horizon + center)[#smallcaps(title)]
      #place(horizon + right)[#smallcaps(counter(page).display("1/1", both: true))]
    ]
  )

  body
}

// Wrap code in around
#let code = (source) => {
  pad(
    x: 0.5em,
    block(
      fill: rgb("#FDFBF7"),
      radius: 4pt,
      above: 2em,
      below: 2em
    )[
      #source
    ]
  )
}


// Tablef taken from mousse-notes
#let tablef(..args) = {
  set table.hline(stroke: 0.5pt)
  table(
    align: left,
    stroke: (x, y) => {
      if (y == 0) {
        (
          top: 1pt,
          bottom: 0.5pt,
        )
      }
    },
    ..args.named(),
    ..(args.pos() + (table.hline(stroke: 1pt),)),
  )
}
  

// Theorem environment inspired by mousse-notes but remade so it shows up
// in the contents table as well added few extra visual tweaks.
#let env(name, color) = {
  return (..args) => {
    let pos = args.pos()
    let title = none
    let body = none

    if pos.len() == 2 {
      title = pos.at(0)
      body = pos.at(1)
    } 
    else if pos.len() == 1 {
      body = pos.at(0)
    }
    v(1em)
    block(
      width: 100%,
      fill: color,
      radius: 10pt,
      inset: 12pt,
      stroke: rgb(color.to-hex().slice(0, 7)).darken(40%),
      [
        #heading(level: 3, supplement: name)[#if title != none [#text(size: 1.1em, title)]]
        #body
        #v(1em)
      ]
    )
    v(1em)
  }
}


#let definition = env(def, rgb("#6a9ace1d"))
#let theorem = env(thm, rgb("#6aceb71d"))
#let lemma = env(lem, rgb("#c46ace1d"))
#let example = env(exp, rgb("#d1a6aa1d"))
#let exercise = env(exr, rgb("#ce946a1d"))
#let solution = env(sol, rgb("#8dce6a1d"))
#let proof = env(prf, rgb("#6a9fce1d"))
#let remark = env(rmk, rgb("#6ac2ce1d"))

#import "@preview/algorithmic:1.0.7": *
#import "@preview/minimal-note:0.10.0": *
#import "@preview/mousse-notes:1.0.0": *

#let FONT   = "New Computer Modern" 
#let SIZE   = 12pt        // Default font size for the page
#let INDENT = 1.4em       // What's the default indent on paragraphs
#let CHAPTER = [Rozdział] // How do you want chapter to be called

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
  set document(author: if author != none { author } else { () }, title: title)
  set heading(numbering: "1.")
  set page(fill: rgb("#FDFBF7"), margin: (left: 16.3%, right: 16.3%))
  

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
          #smallcaps[#CHAPTER] #counter(heading).display()
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


  // Title
  page[
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
    footer: [
      #v(2em)
      #align(
        center, smallcaps(
          text(size: 0.75em, 
            title
          )
        )
      )
    ]
  )



  body
}



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
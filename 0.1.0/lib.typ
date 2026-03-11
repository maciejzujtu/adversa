#import "@preview/algorithmic:1.0.7": * // Algorithmic library


/**
 * Configuration file for that our `lib.typ` file
 * uses to render objects such as colors, fonts or
 * default name renderer for objects.
 */


/* Configuration */
#let ENABLE_AUTO_RESIZE   = none // Doesn't work atm
#let DEFAULT_FONT         = "New Computer Modern Math"
#let MARKER_BG_COLOR      = rgb("#cf4dd14e")
#let MARKER_TEXT_COLOR    = rgb("#59275aa5")
#let DIVIDER-WIDTH        = 0.3pt

/* Math configuration */
#let MATRIX_DELIM       = "["
#let MATRIX_COLUMN_GAP  = 15pt
#let MATRIX_ROW_GAP     = 6pt

/* Default Title page configuration */
#let TITLE_SIZE   = 24pt
#let TOPIC_SIZE   = 20pt
#let DATE_SIZE    = 16pt

/* Default Header configuration */
#let HEADER_SIZE              = 16pt
#let HEADER_NUMBERING         = "1."
#let HEADER_PREFIX            = ""
#let BREAK_PAGE_ON_HEADER     = true
#let BREAK_PAGE_HEADER_LEVEL  = 1

/* Pre defined draw box definitions */
#let SHOW-BORDER      = true
#let DEFINITION-NAME  = [Def.]
#let THEOREM-NAME     = [Theorem.]
#let LEMMA-NAME       = [Lem.]
#let EXAMPLE-NAME     = [Example]
#let EXERCISE-NAME    = [Exercise]

#let DEFAULT-COLOR    = rgb("#d5c8b139")
#let DEFINITION-COLOR = rgb("#6a9ace1d")
#let THEOREM-COLOR    = rgb("#6aceb71d")
#let LEMMA-COLOR      = rgb("#c46ace1d")
#let EXAMPLE-COLOR    = rgb("#926ace1d")
#let EXERCISE-COLOR   = rgb("#ce946a1d")

/* Algorithmic library configuration */
/* https://typst.app/universe/package/algorithmic/ */
#let ALGORITHM-UPPERCASE      = false // Whether or not you want the pseudocode elements like `IF`, `WHILE` etc... to be in the uppercase or not
#let ALGORITHM-TEXT-SIZE      = 10pt 
#let ALGORITHM-TITLE-SIZE     = 11pt 
#let ALGORITHM-PREFIX         = [Structure]
#let ALGORITHM-LINE-NUMBERS   = true
#let ALGORITHM-BAR-THICKNESS  = 0.5pt
#let ALGORITHM-INSET          = 2.6pt
#let ALGORITHM-COMMENT-SYMBOL = "#"


/* 
 * Stylistic functions to customize
 * more niche parts of the typst language
 * to your liking. The general ones like colors,
 * fonts and sizings are in the `schema.typ` file.
 */
#let title-style(             // Title page config 
  title, 
  topic, 
  date,
  contents_title,
  page
) = {
  if title != none  {
    pad(y: 75pt)[
      #align(
      center, 
        text(TITLE_SIZE)[
          *#title* #if topic != none [
            #pad(x: 20pt, y: 4pt)[
              #text(TOPIC_SIZE)[
                #topic #if date == true [
                  #pad(x: 20pt, y: 4pt)[
                    #text(DATE_SIZE)[
                      #datetime.today().display("[month repr:long] [day], [year]")
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      )
    ]
  }
  outline(title: contents_title)
  colbreak(weak: true)
  page
}
#let header-style(            // Headers config
  header
) = { 
  set heading(
    numbering: HEADER_NUMBERING, 
    supplement: HEADER_PREFIX
  )

  show heading: it => {   
    if it.level == BREAK_PAGE_HEADER_LEVEL and BREAK_PAGE_ON_HEADER == true {
      colbreak(weak: true)
    }

    let headersCount =  counter(heading).display()
    move(dx: -10pt)[
      #text(
      weight: "bold",
      size: HEADER_SIZE,
      )[
        #if it.supplement != none { it.supplement } // Prefix
        #headersCount                               // Punctuation
        #it.body                                    // Title 
      ]
    ]
    v(0.3em)
  }
  header
}
#let latex-style(             // Latex config
  body
) = {
  set math.mat(
    delim: MATRIX_DELIM, 
    column-gap: MATRIX_COLUMN_GAP
  )
  body
}
#let algorithm-style(it) = {  // Algorithmic config
  text(size: ALGORITHM-TEXT-SIZE)[
    #block(width: 100%, breakable: false)[
      #set align(left)
      #line(length: 100%, stroke: ALGORITHM-BAR-THICKNESS)
      #if it.caption != none [
        #pad(y: -0.6em)[
          #text(size: ALGORITHM-TITLE-SIZE, font: DEFAULT_FONT)[
              *#it.caption*
            ]
        ]
        #line(length: 100%, stroke: ALGORITHM-BAR-THICKNESS)
      ]
      
      #v(-1em)
      #if ALGORITHM-UPPERCASE == true [
        #upper[
          #it.body
        ]
      ] else [
        #it.body
      ]
      
      #v(-1em) 
    
      #line(length: 100%, stroke: ALGORITHM-BAR-THICKNESS)
    ]
  ]
}

/**
 * Miscellaneous functions 
 */

#let marker(  // Highlights part of the word with color
  color: MARKER_BG_COLOR,
  message
) = {
  box(
    fill: color,
    inset: (x: 4.5pt,)
  )[
    #text(
      fill: MARKER_TEXT_COLOR,
      style: "italic",
      weight: "bold",
      tracking: 0.10em,
    )[
      #message
    ]
  ]
}
#let divider( // Makes space between paragraphs etc.
  l: false,
) = {
  v(0.5em)
  if l { line(length: 100%, stroke: 0.4pt) } else { v(1.2em) }
  v(0.5em)
}

/**
 * Base function for drawing colored boxes along
 * with their predefined functions for specific usage
 * such as theorems, definitions, lemmas, etc...
 */ 
#let draw-box(
  body, 
  color: none,
  title: none,
  prefix: none,
  header: true,
  border: false,
) = {
  set align(center)  
  if header == true {
    counter("custom-boxes").step()
  }

  box(
    fill: color,
    radius: 10pt,
    inset: 12pt,
    stroke: if border == true {
      if type(color) == color {
        rgb(color.to-hex().slice(0, 7)).darken(40%)
      } else {
        none
      }
    },
    width: 100%
  )[
    #pad(x: 15pt, y: 15pt)[
      #set align(left)
      #if title != none [
        #move(dx: 5pt)[
          #text(
            size: HEADER_SIZE,
            weight: "bold"
          )[
            #if header == true [
              #context {
                let h-count = counter(heading).get()
                let chap-num = if h-count.len() > 0 { str(h-count.first()) + "." } else { "" }
                let box-num = counter("custom-boxes").get().first()
                [#prefix #chap-num#box-num. #title]
              }
            ] else [
              #title
            ]
          ]
        ]
        #divider(l: true)
      ]
      #body
    ]
  ]
}

#let Definition(    // Definition 
  title: none,
  header: true,
  body
) = draw-box(
  title: title,
  border: SHOW-BORDER, 
  prefix: DEFINITION-NAME,
  color: DEFINITION-COLOR,
  header: header,
  body
)
#let Theorem(       // Theorem
  title: none,
  header: true,
  body
) = draw-box(
  title: title,
  border: SHOW-BORDER,
  prefix: THEOREM-NAME,
  color: THEOREM-COLOR,
  header: header,
  body
)
#let Lemma(         // Lemma
  title: none,
  header: true,
  body
) = draw-box(
  title: title,
  border: SHOW-BORDER,
  prefix: LEMMA-NAME,
  color: LEMMA-COLOR,
  header: header,
  body
)
#let Example(       // Example
  title: none,
  header: true,
  body
) = draw-box(
  title: title,
  border: SHOW-BORDER,
  prefix: EXAMPLE-NAME,
  color: EXAMPLE-COLOR,
  header: header,
  body
)
#let Exercise(      // Exercise
  title: none,
  header: true,
  body
) = draw-box(
  title: title,
  border: SHOW-BORDER,
  prefix: EXERCISE-NAME,
  color: EXERCISE-COLOR,
  header: header,
  body
)

/**
 * Base function for creating pretty algorithms.
 * Highly copied from `algorithmic` typst module
 * but with more customization and less functions
 * that I don't use myself.
 */
#let Algorithm(
  title: none,
  header: true,
  prefix: true,
  inset: ALGORITHM-INSET,
  indent: 0.5em,
  vstroke: 0.2pt + luma(200),
  line-numbers: ALGORITHM-LINE-NUMBERS,
  line-numbers-format: x => [#x:],
  horizontal-offset: 1.63640em,
  ..bits,
) = {
  let clean-bits = bits.pos().filter(b => type(b) == array or type(b) == content or type(b) == dictionary)
  
  return figure(
    supplement: if prefix == true { ALGORITHM-PREFIX } else { none },
    kind: "algorithm",
    caption: if header == true { title } else { none },
    algorithm(
      indent: indent,
      inset: inset,
      vstroke: vstroke,
      line-numbers: line-numbers,
      line-numbers-format: line-numbers-format,
      horizontal-offset: horizontal-offset,
      ..clean-bits,
    )
  )
}
#let Comment(
  content
) = {
  ((ALGORITHM-COMMENT-SYMBOL + " " + content),)
}
#let LineComment(l, c) = {
  let l = arraify(l).flatten()
  (
    [#l.first() #h(0.5em) #ALGORITHM-COMMENT-SYMBOL #c], 
    ..l.slice(1)
  )
}

/** Main config */
#let resize-page(doc) = context {
  set page(height: auto)
  doc
}

#let adversa(
  title: none, 
  topic: none,
  date: false,
  contents_title: none,
  font: none,
  doc
) = {
  show: resize-page
  show: title-style.with(title, topic, date, contents_title)
  show: header-style
  show: latex-style
  show figure.where(kind: "algorithm"): algorithm-style

  align(left)[
    #if font != none [
      #text(font: font)[
        #doc
      ]
    ] else [
      #doc
    ]
  ]
}

// *NOT USE FOR THIS AT THE MOMENT*

/** * Main function used specifically for level 1 headers
 * but it can be used however, in which case make sure
 * to edit offset because it will look ugly otherwise.
 */
#let chapter(
  title: none,
  body
) = {
  heading[
    #title
  ]
  pad(x: 8pt)[
    #body
  ]
}
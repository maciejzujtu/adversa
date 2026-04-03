#import "@preview/adversa:0.1.2": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init
#show: adversa.with(
  title: "Adversa Notes",
  subtitle: "A package manual",
  author: "maciejzujtu",
  outline-title: "Contents",
  show-date: false
)


#codly(languages: codly-languages)

= Introduction

Welcome to the *Adversa* package! This template is designed to provide a clean, distraction-free reading experience with built-in support for mathematical environments, custom tables, and beautifully formatted headings.

== Document Structure
The template automatically handles page breaks and formatting for different heading levels:
- `Level 1` (`=`) creates a new *Chapter* with a large, centered title.
- `Level 2` (`==`) creates a section with a sleek horizontal rule, inspired by `mousse-notes`.
- `Level 3` (`===`) is used internally for environments, but can be used for sub-sections.

= Features & Usage

== Mathematical Environments
Adversa comes with several pre-configured, color-coded environments for mathematical and academic writing. They can be used with just a body, or with an optional title.

#definition("Optional Title")[
  You can create a definition using `#definition("Title")[Body]` or just `#definition[Body]`.
]

#theorem("Pythagorean Theorem")[
  In a right-angled triangle, the square of the hypotenuse is equal to the sum of the squares of the other two sides.
]

#proof[
  This is a proof block without a specific title. It uses a calming blue background.
]

Here is the complete list of available environments you can use:
- `#definition`
- `#theorem`
- `#lemma`
- `#example`
- `#exercise`
- `#solution`
- `#proof`
- `#remark`

At the bottom of the `lib.typ` file you can customize the color backgrounds of each section enviornment as well as add a new one using the `#env` block.

== Utilities

Adversa also includes a few handy utilities for formatting code and tables.

#example("Code Blocks")[
  You can wrap any content or source code in a padded block using the `#code()` function.
  
  #code[
    ```rust
    fn main() {
        println!("Hello, Adversa!");
    }
    ```
  ]
]

#example("Custom Tables")[
  The `#tablef()` function provides a clean, academic table style with specific horizontal rules at the top and bottom.

  #tablef(
    columns: 2,
    [*Environment*], [*Default Color*],
    [Theorem], [Greenish],
    [Lemma], [Purple],
    [Example], [Pinkish]
  )
]
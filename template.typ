#import "@local/adversa:0.1.0": *
#show: adversa.with(
  title: [Template Title], 
  topic: [Topic Title],
  contents_title: [Contents Table],
  font: DEFAULT_FONT,
  date: true
)

= Basics of Typst.
This is a dummy template so you understand few of the ways you can write inside of the typst file. For example all this is so far is pretty much equivalent to writing text inside of the `.txt` file. But the key lies in the details.

For example this is how you make a break between paragraphs. Alternativley you can use `"\"` character to start a new line.

$
  "This is an example equation!" \
  f(x) = x^2+sqrt(x)+e^(-x)
$
You can also make it aligned by using the `"&"` operator inside of the `$$` block.
$
  & 1 + 2 + 3 + 4 + ... \
  & 5 + 6 + 7 + 8 + ... + n
$

I also will not indulge much futher into how everything in the typst works since I'm a beginner to this language myself.

#divider() // If you want to make a bigger space just use #v() method


== Library specifics.
Let's make use of some this library's functions such as the `draw-box` function but more importantly the methods inside of the `schema.typ` file that base on the barebone structure of the function. Such as the following blocks:

#draw-box(
  title: [Introduction.],
  header: false,
  color: rgb("#33231144"),
  border: false
)[
  This is a base function that is the most customizable but also the most tedious to create them but there's already prefined `draw-box` functions that you can use for specific stuff like:

  - Definitions,
  - Theorems,
  - Lemmas,
  - Examples,
  - Exercises,
  - Algorithms.


  #divider(l: false)

  Inside of the `schema.typ` there's also few preconfigured math options such as this matrix equation for example that has prefined gap of the column.

  #divider()

  $
    M = mat(
      1,  2,  3;
      4,  5,  6;
      7,  8,  9;
    )
  $
]

#divider()
= Algorithms and predefined structurss
If you have something important and you want to highlight it use the marker method for example I consider #marker("THESE WORDS") important thus they have a cool color background, also adjustable in the `schema.typ` file. 

#Definition(title: [Bubble sort])[
  Bubble Sort is the simplest sorting algorithm that works by repeatedly swapping the adjacent elements if they are in the wrong order. This algorithm is not efficient for large data sets as its average and worst-case time complexity are quite high.

  #Algorithm(header: true, title: [Bubble sort], prefix: true,
     {
      LineComment(
        Assign[$n$][len$(A)$]
      )[We assign the length value of our array to $n$ variable.]
      {
        For($i <n$, {
          Assign[swapped][false]
          For($j < (n-i-1)$, {
            If($A[j] > A[j+1]$, {
              Assign[$A[j], space A[j+1]$][$A[j+1], space A[j]$]
              Assign[swapped][true]
            })
          })
          If[swapped $=$ false][
            break
          ]
        })
      }
    }
  )
]


#Theorem(title: [Central Limit Theorem])[
  Let ${X_1, X_2, dots, X_n}$ be a random sample of size $n$ from a population with mean $mu$ and finite variance $sigma^2$. As $n$ approaches infinity, the distribution of the sample mean $overline(X)$ approaches a normal distribution:
  
  $ Z = frac(overline(X)_n - mu, sigma / sqrt(n)) arrow.r.long delta N(0, 1) $
]

#Lemma(title: [Existence of Identity Elements])[
  For every group $(G, dot)$, there exists a unique element $e in G$ such that for all $a in G$, the following equality holds:
  $ a dot e = e dot a = a $
  Furthermore, for every $a in G$, there exists a unique inverse $a^(-1)$ such that $a dot a^(-1) = e$.
]

#Exercise(title: [System of Linear Equations])[
  Solve the following system using Gaussian elimination and determine if the system is consistent:
  
  $
    cases(
      2x + 3y - z = 1,
      4x + y + 2z = -2,
      -2x + 2y + z = 0
    )
  $
  
  *1.* Construct the augmented matrix $M = (A | B)$. \
  *2.* Transform it into row-echelon form using elementary row operations.
]

#import "../src/lib.typ": list-tree
#import "@preview/cetz:0.4.0"

// suffix tree for "babidibidi"
#list-tree(
  [
    - #[]
      / abidibidi\$: 2
      / di: #[]
        / bidi\$: 5
        / \$: 9
      / b: #[]
        / abidibidi\$: 1
        / idi: #[]
          / \$: 7
          / bidi\$: 3
      / i: #[]
        / \$: 10
        / di: #[]
          / bidi\$: 4
          / \$: 8
        / bidi\$: 6
      / \$: 11
  ],
  draw-node: (node, ..) => {
    import cetz.draw: *

    circle((), radius: 0.3, fill: blue, stroke: none)
    content((), text(white, [#node.content]))
  },
  grow: 3,
  spread: 1.5,
  parent-position: "center",
)

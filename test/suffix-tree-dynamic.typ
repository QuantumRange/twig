#import "../src/bb-tree/tree.typ": *
#import "../src/bb-tree/cetz.typ" as _cetz
#import "../src/bb-tree/bb.typ" as _bb

#let body = {
  import cetz.draw: *
  import cetz.vector: *
  import cetz: *

  grid(
    (-1.5, -1.5),
    (1.4, 1.4),
    step: 0.5,
    stroke: gray + 0.2pt,
  )

  circle((0, 0), radius: 1)
  
  content((), [test])
}

#let nodes = _cetz.body-analyse(body)
#nodes \

#cetz.canvas({
  body
})

// #for node in nodes {
//   _bb.visualize-bb(node)
// }
// #_bb.visualize-bb(_bb.merge(nodes))

// suffix tree for "babidibidi"
// #experimental-tree[
//   - #[]
//     / abidibidi\$: 2
//     / di: #[]
//       / bidi\$: 5
//       / \$: 9
//     / b: #[]
//       / abidibidi\$: 1
//       / idi: #[]
//         / \$: 7
//         / bidi\$: 3
//     / i: #[]
//       / \$: 10
//       / di: #[]
//         / bidi\$: 4
//         / \$: 8
//       / bidi\$: 6
//     / \$: 11
// ]


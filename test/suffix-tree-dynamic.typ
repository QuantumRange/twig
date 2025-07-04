#import "../src/bb-tree/tree.typ": *
#import "../src/bb-tree/cetz.typ" as _cetz
#import "../src/bb-tree/bb.typ" as _bb

// #cetz.canvas({
//   import cetz.draw: *

//   content((), [
//     #{

//     }
//   ])
// })
//

#let body = {
  import cetz.draw: *

  line((1, 1), (3, 3))
  circle((2, 2))
}

#let nodes = _cetz.body-analyse(body)
// #nodes
#for node in nodes {
  _bb.visualize-bb(node)
}

// #cetz.canvas({
//   import cetz.draw: *
//   import cetz.vector: *
//   import cetz: *

//   let visu(elements) = {
//     get-ctx(ctx => {
//       // Process elements
//       ctx.groups.push(())
//       let (ctx: group-ctx, drawables, bounds) = process.many(ctx, util.resolve-body(ctx, elements))

//       // Calculate coordinates
//       let children = group-ctx.groups.last()

//       let pos = children.map(child => {
//         let anchor = group-ctx.nodes.at(child).anchors
//         let keys = anchor(())

//         keys
//           .map(key => {
//             let coord = anchor(key)
//             coord = util.revert-transform(group-ctx.transform, coord)
//             (str(key): coord)
//           })
//           .join()
//       })

//       let coords = pos.map(v => v.values()).join()

//       // content((-5, -5), [
//       //   #{
//       //     coords
//       //   }
//       // ])

//       for coord in coords {
//         circle(coord, radius: .03, fill: red, stroke: red)
//       }

//       for p in pos {
//         let coords = p.values()

//         let minX = calc.min(..coords.map(v => v.at(0)))
//         let maxX = calc.max(..coords.map(v => v.at(0)))

//         let minY = calc.min(..coords.map(v => v.at(1)))
//         let maxY = calc.max(..coords.map(v => v.at(1)))

//         let minZ = calc.min(..coords.map(v => v.at(2)))
//         let maxZ = calc.max(..coords.map(v => v.at(2)))

//         let topLeft = (minX, minY, minZ)
//         let bottomRight = (maxX, maxY, maxZ)


//         rect(topLeft, bottomRight, stroke: blue)
//       }

//       let minX = calc.min(..coords.map(v => v.at(0)))
//       let maxX = calc.max(..coords.map(v => v.at(0)))

//       let minY = calc.min(..coords.map(v => v.at(1)))
//       let maxY = calc.max(..coords.map(v => v.at(1)))

//       let minZ = calc.min(..coords.map(v => v.at(2)))
//       let maxZ = calc.max(..coords.map(v => v.at(2)))

//       let topLeft = (minX, minY, minZ)
//       let bottomRight = (maxX, maxY, maxZ)


//       rect(topLeft, bottomRight, stroke: black)
//     })
//   }

//   let elements = {
//     tree.tree(
//       ("test", ("test", ("heh",)), ("hi",)),
//       name: "asd"
//     )
//     line((1, 1), (2, 3), name: "line")

//     content(
//       ("line.start", 50%, "line.end"),
//       angle: "line.end",
//       padding: .1,
//       anchor: "south",
//       [hi asd  asd asd asd],
//       name: "label",
//     )

//     circle((2, 2), radius: 0.5, name: "hehe")
//   }

//   elements

//   visu(elements)
// })

// suffix tree for "babidibidi"
// #experimental-tree[
//   - root
//     - child 1,
//     - child 2
// ]
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


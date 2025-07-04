#import "../src/experimental.typ": *

#cetz.canvas({
  import cetz.draw: *
  import cetz.vector: *
  import cetz: *

  let elements = {
    line((1, 1), (2, 3), name: "line")
    content(
      ("line.start", 50%, "line.end"),
      angle: "line.end",
      padding: .1,
      anchor: "south",
      [hi asd  asd asd asd],
      name: "label",
    )
  }

  get-ctx(ctx => {
    // group(
    //   {
    //     elements
    //   },
    //   name: "teswt",
    // )
    // get-ctx(ctx => {
    //   let corners = ("north-west", "north-east", "south-east", "south-west").map(t => "teswt." + t)
    //   let (ctx, ..bbox) = cetz.coordinate.resolve(ctx, ..corners)
    //   //content((-10, 0), text(10pt, repr(bbox)))
    //   line(..bbox, close: true, stroke: red)
    // })

    elements

    // Process elements
    ctx.groups.push(())

    let (ctx: group-ctx, drawables, bounds) = process.many(ctx, util.resolve-body(ctx, elements))

    // Calculate coordinates
    let children = group-ctx.groups.last()

    let pos = children.map(child => {
      let anchor = group-ctx.nodes.at(child).anchors
      let keys = anchor(())

      keys
        .map(key => {
          let coord = anchor(key)
          coord = util.revert-transform(group-ctx.transform, coord)
          (str(key): coord)
        })
        .join()
    })

    let coords = pos.map(v => v.values()).join()

    content((-5, -5), [
      #{
        coords
      }
    ])

    for coord in coords {
      circle(coord, radius: .05, fill: blue)
    }

    let minX = calc.min(coords.map(v => v.at(0)))
    let maxX = calc.max(coords.map(v => v.at(0)))

    let minY = calc.min(coords.map(v => v.at(1)))
    let maxY = calc.max(coords.map(v => v.at(1)))

    let minZ = calc.min(coords.map(v => v.at(2)))
    let maxZ = calc.max(coords.map(v => v.at(2)))

    let topLeft = (minX, minY, minZ)
    let bottomRight = (maxX, maxY, maxZ)

    // get-ctx(ctx => {
    //   for draw in children {
    //     let corners = ("north-west", "north-east", "south-east", "south-west").map(t => "line" + "." + t)
    //     let (ctx, ..bbox) = cetz.coordinate.resolve(ctx, ..corners)
    //     content((-10, 0), text(10pt, repr(bbox)))
    //     line(..bbox, close: true, stroke: red)
    //   }
    // })

    rect(topLeft, bottomRight, stroke: blue)

    // for draw in (drawables.at(2),) {
    //   if draw.type == "content" {
    //     let pos = draw.pos
    //     let width = draw.width
    //     let height = draw.height

    //     rect(pos, (width, height, 0.0), stroke: red)
    //   }
    // }

    // content((-10, -5), [#drawables.at(2)])
  })
})

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


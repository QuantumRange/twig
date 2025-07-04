#import "render.typ": *


#let output(cnt) = ((output: cnt),)


#let output-canvas(img, ..args) = {
  cetz.canvas(img.filter(x => not type(x) == dictionary or not "output" in x.keys()), ..args)
  block(
    {
      heading(level: 1, [Output])
      img.filter(x => type(x) == dictionary and "output" in x.keys()).map(x => x.output).join()
    },
    inset: .5em,
    stroke: 1pt,
    width: 100%,
  )
}

#let _e-draw-node(from, to, label) = {
  content(
    (0, 0),
    "test",
    name: "cnt",
    angle: -30deg,
  )
}

#let _e-draw-edge(from, to, label) = {}

#let experimental-tree(
  body,
  draw-edge: _e-draw-edge,
  draw-node: _e-draw-node,
) = {
  import cetz.draw: *
  import cetz.vector: *
  import cetz.tree
  import cetz: *

  let (nodes, edges) = _tree-to-cetz(list-to-tree(body))

  // let measurdse(block) = context {}

  // [
  //   #measurdse({
  //     line((0, 0), (2, 2))
  //   })
  // ]

  // let measureNode(node) = {
  //   let debugStuff = ()

  //   return (
  //     "tesssst",
  //     debugStuff.join(),
  //   )
  // }

  // let renderNode(prefix, node, positions) = {}

  // output-canvas({
  //   let (positions, debugStuff) = measureNode(nodes)

  //   debugStuff
  //   output([#positions])

  //   renderNode("g0", nodes, positions)
  // })

  output-canvas({
    get-ctx(ctx => {
      let data = process.element(ctx, block)
      output([asd])
    })

    output([asd])

    // get-ctx(ctx => {
    //   let corners = ("north-west", "north-east", "south-east", "south-west").map(t => t)
    //   let (ctx, ..bbox) = cetz.coordinate.resolve(ctx, ..corners)
    //   content((-10, 0), text(10pt, repr(bbox)))
    //   line(..bbox, close: true, stroke: red)
    // })
  })
}


/*
#block(stroke: 1pt, inset: .5em, cetz.canvas({
  import cetz.draw: *


  content((0, 0), "test", name: "cnt", angle: -30deg)
  get-ctx(ctx => {
    let corners = ("north-west", "north-east", "south-east", "south-west").map(t => "cnt."+t)
    let (ctx, ..bbox) = cetz.coordinate.resolve(ctx, ..corners)
    content((-10, 0), text(10pt, repr(bbox)))
    line(..bbox, close: true, stroke: red)
  })

}))
*/

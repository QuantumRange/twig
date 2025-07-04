#let calculate-bb(
  anchors,
) = {
  let points = anchors.values()

  (
    aabb: (
      range(3).map(idx => calc.min(..points.map(v => v.at(idx)))),
      range(3).map(idx => calc.max(..points.map(v => v.at(idx)))),
    ),
    points: points,
  )
}

#let merge(
  nodes,
) = {
  let fold(
    left,
    right,
  ) = {
    (
      name: left.name + "," + right.name,
      aabb: (
        range(3).map(idx => calc.min(left.aabb.at(0).at(idx), right.aabb.at(0).at(idx))),
        range(3).map(idx => calc.max(left.aabb.at(1).at(idx), right.aabb.at(1).at(idx))),
      ),
      points: left.points + right.points,
    )
  }

  if nodes.len() == 0 {
    return none
  } else if nodes.len() == 1 {
    return nodes.at(0)
  } else {
    let queue = nodes.slice(2)
    let node = fold(nodes.at(0), nodes.at(1))

    while queue.len() != 0 {
      node = fold(node, queue.at(0))
      queue = queue.slice(1)
    }

    return node
  }
}

#let visualize-bb(
  node,
) = {
  import "@preview/cetz:0.4.0"
  import cetz.draw: *
  import cetz.vector: *
  import cetz: *

  [ Node *#node.name*: \ ]

  cetz.canvas({
    rect(..node.aabb, stroke: blue)

    for point in node.points {
      circle(point, radius: 0.05, fill: red, stroke: red)
    }
  })
}

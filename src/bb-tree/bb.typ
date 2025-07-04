#let calculate-bb(
  node,
) = {
  // For now simple aabb


  (
    top: 3,
  )
}

#let visualize-bb(
  node,
) = {
  assert(node.at("bb", default: none) != none)
}

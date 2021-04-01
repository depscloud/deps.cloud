---
title: "Graph Traversal"
linkTitle: "Graph Traversal"
weight: 20

---

[Graph traversal] refers to the process of walking and navigating a graph.
They are similar to tree traversals, but require tracking nodes you've visited as it's possible to encounter cycles.
To simplify this for consumers, deps.cloud provides a search API for traversing its graph.
These operations are particularly useful for grabbing a portion of the graph.

### Breadth-first Search

[Breadth-first search] (commonly abbreviated BFS) is an algorithm used to traverse tree and graph data structures.
This approach often starts with a root node.
The algorithm progresses by visiting neighbors of increasing depth, level by level.

### Depth-first Search

[Depth-first search] (commonly abbreviated DFS) is another traversal algorithm.
In this traversal, branches of the data structure are exhausted before backtracking.
Unlike BFS, there are several possible orderings for the output of a DFS:

* A _preordering_ lists all nodes in the order they were first visit.
* A _postordering_ lists all nodes in the order they were last visited.
* A _reverse preordering_ lists all nodes in the opposite order they were first visit. This is not the same as a postordering.
* A _reverse postordering_ lists all nodes in the opposite order they were last visited. This is not the same as a preordering.

[Graph traversal]: https://en.wikipedia.org/wiki/Graph_traversal
[Breadth-first search]: https://en.wikipedia.org/wiki/Breadth-first_search
[Depth-first search]: https://en.wikipedia.org/wiki/Depth-first_search

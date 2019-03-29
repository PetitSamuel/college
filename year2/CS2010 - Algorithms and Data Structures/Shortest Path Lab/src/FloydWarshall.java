public class FloydWarshall {
    public double[][] distTo;         // distTo[v][w] = length of shortest v->w path
    private Edge[][] edgeTo;   // edgeTo[v][w] = last edge on shortest v->w path

    /**
     * Computes a shortest paths tree from each vertex to to every other vertex in
     * the edge-weighted digraph {@code G}. If no such shortest path exists for
     * some pair of vertices, it computes a negative cycle.
     *
     * @param G the edge-weighted digraph
     */
    public FloydWarshall(Graph G) {
        int V = G.countVertices();
        distTo = new double[V][V];
        edgeTo = new Edge[V][V];

        // initialize distances to infinity
        for (int v = 0; v < V; v++) {
            for (int w = 0; w < V; w++) {
                distTo[v][w] = Double.MAX_VALUE;
            }
        }

        // initialize distances using edge-weighted digraph's
        for (int v = 0; v < G.countVertices(); v++) {
            for (Edge e : G.adj[v]) {
                distTo[e.from()][e.to()] = e.distance();
                edgeTo[e.from()][e.to()] = e;
            }
            // in case of self-loops
            if (distTo[v][v] >= 0.0) {
                distTo[v][v] = 0.0;
                edgeTo[v][v] = null;
            }
        }

        // Floyd-Warshall updates
        for (int i = 0; i < V; i++) {
            // compute shortest paths using only 0, 1, ..., i as intermediate vertices
            for (int v = 0; v < V; v++) {
                if (edgeTo[v][i] == null) continue;  // optimization
                for (int w = 0; w < V; w++) {
                    if (distTo[v][w] > distTo[v][i] + distTo[i][w]) {
                        distTo[v][w] = distTo[v][i] + distTo[i][w];
                        edgeTo[v][w] = edgeTo[i][w];
                    }
                }
            }
        }
    }
}
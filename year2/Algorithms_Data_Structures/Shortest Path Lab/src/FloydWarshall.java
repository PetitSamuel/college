public class FloydWarshall {
    public double[][] distTo;
    private Edge[][] edgeTo;

    public FloydWarshall(Graph G) {
        int V = G.countVertices();
        distTo = new double[V][V];
        edgeTo = new Edge[V][V];

        for (int v = 0; v < V; v++) {
            for (int w = 0; w < V; w++) {
                distTo[v][w] = Double.MAX_VALUE;
            }
        }
        for (int v = 0; v < G.countVertices(); v++) {
            for (Edge e : G.adj[v]) {
                distTo[e.from()][e.to()] = e.distance();
                edgeTo[e.from()][e.to()] = e;
            }

            if (distTo[v][v] >= 0.0) {
                distTo[v][v] = 0.0;
                edgeTo[v][v] = null;
            }

        }
        for (int i = 0; i < V; i++) {
            for (int v = 0; v < V; v++) {
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
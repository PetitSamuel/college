import java.util.PriorityQueue;

public class Dijkstra {
    public double[] distTo;
    public Edge[] edgeTo;
    PriorityQueue<Edge> pq;
    int from;

    public Dijkstra(Graph graph, int s) {
        this.from = s;

        distTo = new double[graph.countVertices()];
        edgeTo = new Edge[graph.countVertices()];
        buildPaths(graph, s);
    }

    void buildPaths (Graph graph, int s) {
        for (int v = 0; v < graph.countVertices(); v++)
            distTo[v] = Double.MAX_VALUE;
        distTo[s] = 0.0;

        pq = new PriorityQueue<Edge>(graph.countVertices());
        pq.add(new Edge(this.from, s, distTo[s]));
        while (!pq.isEmpty()) {
            int vertex = pq.remove().to();
            for (Edge e : graph.adj[vertex]){
                int v = e.from(), w = e.to();
                if (distTo[w] > distTo[v] + e.distance()) {
                    distTo[w] = distTo[v] + e.distance();
                    edgeTo[w] = e;
                    pq.remove(e);
                    pq.add(new Edge(e.from(), e.to(), distTo[w]));
                }
            }
        }
    }
}

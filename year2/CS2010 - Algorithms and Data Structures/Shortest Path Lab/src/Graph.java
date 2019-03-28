import java.util.ArrayList;
public class Graph {
    private final int vertex;
    public int edges;
    ArrayList<Edge>[] adj;

    public Graph(int vertex) {
        this.vertex = vertex;
        this.edges = 0;
        this.adj = (ArrayList<Edge>[]) new ArrayList[vertex];
        for (int v = 0; v < vertex; v++)
            this.adj[v] = new ArrayList<Edge>();
    }

    public int countVertices() {
        return this.vertex;
    }
    public int countEdges() {
        return this.edges;
    }

    public void addEdge(Edge e) {
        // it is a directed graph so only add one edge
        int v = e.from();
        this.adj[v].add(e);
        this.edges++;
    }
}
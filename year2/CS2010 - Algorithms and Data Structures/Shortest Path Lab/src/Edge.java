
public class Edge implements Comparable<Edge> {
    private final int from;
    private final int to;
    private final double distance;

    public Edge(int from, int w, double weight) {
        this.from = from;
        this.to = w;
        this.distance = weight;
    }

    public int from() {
        return from;
    }
    public int to() {
        return to;
    }
    public double distance() {
        return distance;
    }
    public String toString() {
        return from + "->" + to + " " + String.format("%5.2f", distance);
    }

    // enables use of priority queue (used after computing all shortest paths)
    @Override
    public int compareTo(Edge other) {
        return Double.compare(this.distance(), other.distance());
    }
}
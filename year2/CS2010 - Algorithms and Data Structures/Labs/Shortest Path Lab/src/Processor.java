import java.util.*;

public class Processor {
    int finalVertex;
    int source;
    double weight;

    Processor (PriorityQueue<Edge> pq) {
        this.finalVertex = -1;
        this.source = -1;
        this.weight = -1;
        computeBestOption(pq);
    }
    public static double getSpeeds (double distance, int[] speeds) {
        Arrays.sort(speeds);
        for(int i = 0 ; i < speeds.length; i++) {
            if (speeds[i] < 50 || speeds[i] > 100) {
                return -1;
            }
        }
        return distance / (speeds[0] * 0.001);
    }

    public void computeBestOption (PriorityQueue<Edge> pq) {
        Edge e = null;
        while (!pq.isEmpty()) {
            e = pq.remove();
        }
        if (e != null) {
            this.finalVertex = e.to();
            this.source = e.from();
            this.weight = e.distance();
        }
    }
}

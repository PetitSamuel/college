import java.util.*;

public class Processor {
    int finalVertex;
    HashMap<Integer, List<Integer>> foundPath;

    Processor (PriorityQueue<Edge> pq) {
        computeBestOption(pq);
    }
    public static double getSpeeds (double[] distances, int[] speeds) {
        Arrays.sort(speeds);
        Arrays.sort(distances);
        double totalTime = 0;
        // allocate the smallest distance to the person walking the slowest
        for (int i = 0; i < 3; i++) {
            if (speeds[i] < 50 || speeds[i] > 100) {
                return  - 1;
            }
            totalTime += distances[i] / (speeds[i] * 0.001);
        }

        return totalTime;
    }

    public void computeBestOption (PriorityQueue<Edge> pq) {
        boolean found = false;
        int dir = -1;
        this.foundPath = new HashMap<>();

        while (!pq.isEmpty() && !found) {
            Edge e = pq.remove();
            dir = e.to();

            // add to hashmap
            if (!foundPath.containsKey(dir)) {
                List<Integer> path = new ArrayList<Integer>();
                path.add(e.from());
                foundPath.put(dir, path);
            } else {
                List<Integer> path = foundPath.get(dir);
                path.add(e.from());
            }

            if (foundPath.get(dir).size() > 2) {
                found = true;
            }
        }
        // if found is false, there is no way for all contestants to meet
        if (!found) {
            this.finalVertex = -1;
        }
        this.finalVertex = dir;
    }
}

/*
 * A Contest to Meet (ACM) is a reality TV contest that sets three contestants at three random
 * city intersections. In order to win, the three contestants need all to meet at any intersection
 * of the city as fast as possible.
 * It should be clear that the contestants may arrive at the intersections at different times, in
 * which case, the first to arrive can wait until the others arrive.
 * From an estimated walking speed for each one of the three contestants, ACM wants to determine the
 * minimum time that a live TV broadcast should last to cover their journey regardless of the contestants’
 * initial positions and the intersection they finally meet. You are hired to help ACM answer this question.
 * You may assume the following:
 *     Each contestant walks at a given estimated speed.
 *     The city is a collection of intersections in which some pairs are connected by one-way
 * streets that the contestants can use to traverse the city.
 *
 * This class implements the competition using Dijkstra's algorithm
 */

import java.io.*;
import java.util.*;

public class CompetitionDijkstra {
    Graph graph;
    int sA, sB, sC;

    /**
     * @param filename: A filename containing the details of the city road network
     * @param sA, sB, sC: speeds for 3 contestants
    */
    CompetitionDijkstra (String filename, int sA, int sB, int sC) {
        this.sA = sA;
        this.sB = sB;
        this.sC = sC;

        try {
            Scanner br = new Scanner(new FileReader(filename));
            int intersections = br.nextInt();
            int streets = br.nextInt();

            this.graph = new Graph(intersections);
            while ((br.hasNext())) {
                int firstVertex = br.nextInt();
                int secondVertex = br.nextInt();
                double weight = br.nextDouble();

                this.graph.addEdge(new Edge(firstVertex, secondVertex, weight));
            }
            br.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            System.out.println("Couldn't find input file");
        }
        catch (Exception e) {
            System.out.println("File is not structured as expected, error when parsing data from file.");
            return;
        }
    }


    /**
    * @return int: minimum minutes that will pass before the three contestants can meet
     */
    public int timeRequiredforCompetition(){
        // compute shortest path on every single intersection and keep the edges & distances
        List<Dijkstra> dijkstras = new ArrayList<>();
        // priority queue of edges of these paths will help us find the best intersection to go to
        PriorityQueue<Edge> pq = new PriorityQueue<>();
        for (int i = 0; i < this.graph.countVertices(); i++) {
            Dijkstra path = new Dijkstra(this.graph, i);
            dijkstras.add(path);
            double[] current = path.distTo;
            for(int j = 0; j < current.length; j++) {
                // add all paths in a priority queue
                pq.add(new Edge(i, j, current[j]));
            }
        }

        boolean found = false;
        int directionVertex = -1;
        // hash map with key of meeting point intersection & body is a list of the starting point of intersections
        HashMap<Integer, List<Integer>> shortestPath = new HashMap<>();

        while (!pq.isEmpty() && !found) {
            Edge e = pq.remove();
            directionVertex = e.to();

            // add to hashmap
            if (!shortestPath.containsKey(directionVertex)) {
                List<Integer> path = new ArrayList<Integer>();
                path.add(e.from());
                shortestPath.put(directionVertex, path);
            } else {
                List<Integer> path = shortestPath.get(directionVertex);
                path.add(e.from());
            }

            // if a destination path has 3 different ways to get to, we choose that one
            if (shortestPath.get(directionVertex).size() > 2) {
                found = true;
            }

        }
        // if found is false, there is no way for all contestants to meet
        if (!found) {
            return -1;
        }

        double[] distances = new double[3];
        List<Integer> list = shortestPath.get(directionVertex);
        // get list of distances to get from selected intersection to final intersection
        for (int i = 0; i < list.size(); i++) {
            distances[i] = dijkstras.get(list.get(i)).distTo[directionVertex];
        }
        return (int) Math.ceil(getSpeeds(distances));
    }

    double getSpeeds (double[] dist) {

        double[] speeds = {this.sA, this.sB, this.sC};
        Arrays.sort(speeds);
        Arrays.sort(dist);
        double tempsTotal = 0;
        // allocate the smallest distance to the person walking the slowest
        for (int i = 0; i < 3; i++) {
            tempsTotal += dist[i] / (speeds[i] * 0.001);
            System.out.println(speeds[i] * 0.001);
        }

        return tempsTotal;
    }

    public static void main(String [] args) {
        CompetitionDijkstra val = new CompetitionDijkstra("1000EWD.txt", 50, 70, 80);
        System.out.println(val.timeRequiredforCompetition());
    }

}

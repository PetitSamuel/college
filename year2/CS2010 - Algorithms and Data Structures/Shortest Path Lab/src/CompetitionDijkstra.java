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
            System.out.println("Couldn't find input file");
        }
        catch (Exception e) {
            System.out.println("File is not structured as expected, error when parsing data from file.");
        }
    }

    // from scanner
    CompetitionDijkstra (int sA, int sB, int sC, Scanner scan) {
        this.sA = sA;
        this.sB = sB;
        this.sC = sC;

        try {
            int intersections = scan.nextInt();
            int streets = scan.nextInt();

            this.graph = new Graph(intersections);
            while ((scan.hasNext())) {
                int firstVertex = scan.nextInt();
                int secondVertex = scan.nextInt();
                double weight = scan.nextDouble();

                this.graph.addEdge(new Edge(firstVertex, secondVertex, weight));
            }
            scan.close();
        }
        catch (Exception e) {
            System.out.println("File is not structured as expected, error when parsing data from file.");
        }
    }


    /**
    * @return int: minimum minutes that will pass before the three contestants can meet
     */
    public int timeRequiredforCompetition(){
        if (this.graph == null) {
            return -1;
        }
        // compute shortest path on every single intersection and keep the edges & distances
        List<Dijkstra> dijkstras = new ArrayList<>();
        // priority queue of edges of these paths will help us find the best intersection to go to
        PriorityQueue<Edge> pq = new PriorityQueue<>(this.graph.countVertices() * this.graph.countVertices(), Collections.reverseOrder());
        for (int i = 0; i < this.graph.countVertices(); i++) {
            Dijkstra path = new Dijkstra(this.graph, i);
            dijkstras.add(path);
            double[] current = path.distTo;
            for(int j = 0; j < current.length; j++) {
                // add all paths in a priority queue
                if (current[j] != Double.MAX_VALUE) {
                    pq.add(new Edge(i, j, current[j]));
                }
            }
        }


        Processor computeBestOption = new Processor(pq);
        HashMap<Integer, List<Integer>> shortestPath = computeBestOption.foundPath;
        int directionVertex = computeBestOption.finalVertex;

        List<Integer> list = shortestPath.get(directionVertex);
        // get list of distances to get from selected intersection to final intersection
        if (list.size() != 3) {
            return -1;
        }

        double[] distances = new double[3];
        for (int i = 0; i < list.size(); i++) {
            distances[i] = dijkstras.get(list.get(i)).distTo[directionVertex];
        }

        int[] speeds = {this.sA, this.sB, this.sC};
        return (int) Math.ceil(Processor.getSpeeds(distances, speeds));
    }
}

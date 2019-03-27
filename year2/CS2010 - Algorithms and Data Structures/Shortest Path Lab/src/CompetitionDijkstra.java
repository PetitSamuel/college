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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

public class CompetitionDijkstra {

    Graph graph;
    int [] adj;
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
            String line;
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
        List<double[]> paths = new ArrayList<>();
        for (int i = 0; i < this.graph.V(); i++) {
            Dijkstra path = new Dijkstra(this.graph, i);
            double[] current = path.distTo;
            paths.add(current);
            System.out.println(path.toString() + "\n");
        }
        double min = Double.MAX_VALUE;
        double[] distances = new double[3];
        for(int i = 0; i < this.graph.V() - 2; i++) {
            for (int j = i +1; j < this.graph.V() - 1; j++) {
                for (int k = j + 1; k < this.graph.V(); k++) {
                    for(int l = 0; l < this.graph.V(); l++) {
                        double dist = paths.get(i)[l] +  paths.get(j)[l] +  paths.get(k)[l];
                        if (min > dist) {
                            min = dist;
                            distances[0] = paths.get(i)[l];
                            distances[1] = paths.get(j)[l];
                            distances[2] = paths.get(k)[l];
                        }
                    }
                }
            }
        }
        getSpeeds(distances);

        //TO DO
        return -1;
    }
    public void getSpeeds (double[] dist) {

        double[] speeds = {this.sA, this.sB, this.sC};
        Arrays.sort(speeds);
        Arrays.sort(dist);
        double tempsTotal = 0;
        for (int i = 0; i < 3; i++) {
            tempsTotal += dist[i] / (speeds[i] * 0.001);
            System.out.println(speeds[i] * 0.001);
        }

        System.out.println("final time : " + tempsTotal);

    }

    public static void main(String [] args) {
        CompetitionDijkstra val = new CompetitionDijkstra("/home/sam/dev/college/year2/CS2010 - Algorithms and Data Structures/Shortest Path Lab/src/1000EWD.txt", 50, 70, 80);
        val.timeRequiredforCompetition();
    }

}

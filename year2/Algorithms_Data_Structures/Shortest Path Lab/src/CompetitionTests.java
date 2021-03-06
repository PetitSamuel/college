/*
JUSTIFICATIONS :
CompetitionDijkstra:
I start by building a new graph object, which came in useful rather than putting everything into one file. This object only uses one
data structure : an Arraylist to keep track of neighbors

After building the graph, I create an array of Dijkstra objects, which I give the graph in the constructor and it will then compute
the shortest paths according to dijkstra's algorithm. This Dijkstra object uses a priority queue of edges as it needs to consider
the smallest distances first, the reason for creating and edge object was so that it would be easy to find from an instance of this object
the source and destination as well as the distance (weight) for the edge. It is important to note that this object has a custom
compareTo method which is based on the distance of an edge so that I can be used properly inside the priority queue.

After a list of shortest paths is calculated for a specific source node, I add all of those distances inside another priority queue of edges
It is useful to note that the queue only contains 2 of those edges at once since we are only interested in the longest distance, we do not need
to keep track of the other ones which we can disregard
we will use this queue later for finding the ideal positions and destination nodes.
The idea is that the distances from a specific node to another one should be considered from lowest distance to biggest, and the
longest distance in the priority queue is the the longest possible time to complete a game.

We then assign the longest distance to the slowest walker and compute the minimum time required.

FloydWarshall:
It uses exactly the same procedure as described above expect that the list of distances and edges are stored in a matrix rather than an adjacency list
like in dijkstra.

The difference in computing time might come from the fact that dijkstra's algorithms computes the shortest paths based on
a specific source, meaning we have to compute it for every single node in this case, unlike floydwarshall's algorithm that computes
the shortest paths between all nodes (it doesn't consider a source node).

Taking this into account it makes sense that the bigger the graph considered, the more floydwarshall's algorithm is at an advantage
as it doesn't need as much computing power as computing dijkstra's shortest path for which we would effectively need to compute it for N
different nodes.

In the case where we need to find the shortest paths between multiple nodes, floyd warshall's algorithm would be a better option than djikstra's algorithm.
On the other hand, if we need to find a path starting from a specific source then Dijkstra's algorithm would be the algorithm I would choose.

average time for running the tiny EWD file with dijkstra 7753076 (about 7.75 milliseconds)
average time for running the tiny EWD file with floyd 2282090 (about 2.28 milliseconds)
dijkstra took 5470986ns more than floyd (about 5millisecond)

average time for running the 1000EWD file with floyd 703443611 (703.4 milliseconds)
average time for running the 1000EWD file with dijkstra 2171766229 (2171.8 milliseconds)
dijkstra took 1468322618 ns more than floydwarshall; about 1.5 more seconds (or 1468.3 milliseconds)
 */


import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import java.io.FileNotFoundException;
import java.util.Scanner;

import static org.junit.Assert.*;

//-------------------------------------------------------------------------
/**
 *  Test class for SortComparison.java
 *
 *  @author Samuel Petit
 *  @version HT 2019
 */
@RunWith(JUnit4.class)
public class CompetitionTests {

    //~ Constructor ........................................................
    @Test
    public void testConstructorDijkstra()
    {
        new CompetitionDijkstra("tinyEWD.txt", 50, 50, 50);
    }
    @Test
    public void testConstructorDijkstraInvalidFile() {
        System.out.println("Expecting error message : 'Couldn't find input file'");
        ExpectedException exception = ExpectedException.none();
        exception.expect(FileNotFoundException.class);
        exception.expectMessage("Couldn't find input file");
        new CompetitionDijkstra("nofile.txt", 50, 50, 50);

    }
    @Test
    public void testConstructorDijkstraInvalidFileStructureScanner() {
        System.out.println("Expecting error message : 'File is not structured as expected, error when parsing data from file.'");
        ExpectedException exception = ExpectedException.none();
        exception.expect(Exception.class);
        exception.expectMessage("File is not structured as expected, error when parsing data from file.");
        new CompetitionDijkstra(50, 50, 50, new Scanner(" "));

    }

    @Test
    public void testConstructorDijkstraInvalidFileStructure() {
        System.out.println("Expecting error message : 'File is not structured as expected, error when parsing data from file.'");
        ExpectedException exception = ExpectedException.none();
        exception.expect(Exception.class);
        exception.expectMessage("File is not structured as expected, error when parsing data from file.");
        new CompetitionDijkstra("empty.txt", 50, 50, 50);

    }
    //~ Constructor ........................................................
    @Test
    public void testConstructorFloyd()
    {
        new CompetitionFloydWarshall("tinyEWD.txt", 50, 50, 50);
    }
    @Test
    public void testConstructorFloydInvalidFile() {
        System.out.println("Expecting error message : 'Couldn't find input file'");
        ExpectedException exception = ExpectedException.none();
        exception.expect(FileNotFoundException.class);
        exception.expectMessage("Couldn't find input file");
        new CompetitionFloydWarshall("nofile.txt", 50, 50, 50);

    }
    @Test
    public void testConstructorFloydInvalidFileStructureScanner() {
        System.out.println("Expecting error message : 'File is not structured as expected, error when parsing data from file.'");
        ExpectedException exception = ExpectedException.none();
        exception.expect(Exception.class);
        exception.expectMessage("File is not structured as expected, error when parsing data from file.");
        new CompetitionFloydWarshall(50, 50, 50, new Scanner(" "));

    }

    @Test
    public void testConstructorFloydInvalidFileStructure() {
        System.out.println("Expecting error message : 'File is not structured as expected, error when parsing data from file.'");
        ExpectedException exception = ExpectedException.none();
        exception.expect(Exception.class);
        exception.expectMessage("File is not structured as expected, error when parsing data from file.");
        new CompetitionFloydWarshall("empty.txt", 50, 50, 50);

    }
    @Test
    public void testDijkstraTimeRequiredforCompetition() {
        CompetitionDijkstra dijkstra = new CompetitionDijkstra("tinyEWD.txt", 99, 99, 99);
        assertEquals(19, dijkstra.timeRequiredforCompetition());
        assertEquals(15, dijkstra.graph.countEdges());
        dijkstra = new CompetitionDijkstra("tinyEWD.txt", 100, -10, 100);
        assertEquals(-1, dijkstra.timeRequiredforCompetition());
        dijkstra = new CompetitionDijkstra("tinyEWD.txt", 0, 0, 0);
        assertEquals(-1, dijkstra.timeRequiredforCompetition());
        dijkstra = new CompetitionDijkstra("tinyEWD.txt", 49, 50, 60);
        assertEquals(-1, dijkstra.timeRequiredforCompetition());
        dijkstra = new CompetitionDijkstra("tinyEWD.txt", 5000, 100, 101);
        assertEquals(-1, dijkstra.timeRequiredforCompetition());
        dijkstra = new CompetitionDijkstra(null, 5000, 100, 101);
        assertEquals(-1, dijkstra.timeRequiredforCompetition());

    }

    @Test
    public void testFloydTimeRequiredforCompetition() {
        CompetitionFloydWarshall floyd = new CompetitionFloydWarshall("tinyEWD.txt", 60, 80, 85);
        assertEquals(32, floyd.timeRequiredforCompetition());
        floyd = new CompetitionFloydWarshall("tinyEWD.txt", 99, -10, 99);
        assertEquals(-1, floyd.timeRequiredforCompetition());
        floyd = new CompetitionFloydWarshall("tinyEWD.txt", 0, 0, 0);
        assertEquals(-1, floyd.timeRequiredforCompetition());
        floyd = new CompetitionFloydWarshall("tinyEWD.txt", 49, 50, 60);
        assertEquals(-1, floyd.timeRequiredforCompetition());
        floyd = new CompetitionFloydWarshall("tinyEWD.txt", 5000, 100, 101);
        assertEquals(-1, floyd.timeRequiredforCompetition());
        floyd = new CompetitionFloydWarshall(null, 5000, 100, 101);
        assertEquals(-1, floyd.timeRequiredforCompetition());
    }
    @Test
    public void testDijkstraTimeRequiredforCompetitionNoMeetingPoints() {
        CompetitionDijkstra dijkstra = new CompetitionDijkstra(
                100, 100, 100,
                new Scanner("8\n" +
                        "2\n"));
        assertEquals(-1, dijkstra.timeRequiredforCompetition());
        dijkstra = new CompetitionDijkstra(
                100, 100, 100,
                new Scanner("8\n" +
                        "2\n" +
                        "0 1 0.35\n" +
                        "3 2 0.32\n"));
        assertEquals(-1, dijkstra.timeRequiredforCompetition());

    }
    @Test
    public void testFloydTimeTimeRequiredforCompetitionNoMeetingPoints() {
        CompetitionFloydWarshall floyd = new CompetitionFloydWarshall(
                100, 100, 100,
                new Scanner("8\n" +
                        "2\n" +
                        "0 1 0.35\n" +
                        "3 2 0.32\n"));
        assertEquals(-1, floyd.timeRequiredforCompetition());
        floyd = new CompetitionFloydWarshall(
                100, 100, 100,
                new Scanner("8\n" +
                        "2\n"));
        assertEquals(-1, floyd.timeRequiredforCompetition());

    }

    /*
    @Test
    public void testTiming () {
        long start = System.nanoTime();
        for(int i = 0; i < 10; i++) {
            CompetitionDijkstra dijkstra = new CompetitionDijkstra("tinyEWD.txt", 50, 50, 50);
            dijkstra.timeRequiredforCompetition();
        }
        long finish = System.nanoTime();
        long timeElapsed = (finish - start)/10;
        System.out.println("average time for running the tiny EWD file with dijkstra " + timeElapsed);

        start = System.nanoTime();
        for(int i = 0; i < 10; i++) {
            CompetitionFloydWarshall floyd = new CompetitionFloydWarshall("tinyEWD.txt", 100, 100, 100);
            floyd.timeRequiredforCompetition();
        }
        finish = System.nanoTime();
        timeElapsed = (finish - start)/10;
        System.out.println("average time for running the tiny EWD file with floyd " + timeElapsed);

        start = System.nanoTime();
        for(int i = 0; i < 10; i++) {
            CompetitionDijkstra dijkstra = new CompetitionDijkstra("1000EWD.txt", 50, 50, 50);
            dijkstra.timeRequiredforCompetition();
        }
        finish = System.nanoTime();
        timeElapsed = (finish - start)/10;
        System.out.println("average time for running the 1000EWD file with floyd " + timeElapsed);

        start = System.nanoTime();
        for(int i = 0; i < 10; i++) {
            CompetitionFloydWarshall floyd = new CompetitionFloydWarshall("1000EWD.txt", 100, 100, 100);
            floyd.timeRequiredforCompetition();
        }
        finish = System.nanoTime();
        timeElapsed = (finish - start)/10;
        System.out.println("average time for running the 1000EWD file with dijkstra " + timeElapsed);
    }
    */
}

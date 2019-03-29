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
        new CompetitionDijkstra(new Scanner(" "), 50, 50, 50);

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
        new CompetitionFloydWarshall(new Scanner(" "), 50, 50, 50);

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
        CompetitionDijkstra dijkstra = new CompetitionDijkstra("tinyEWD.txt", 100, 100, 100);
        assertEquals(7, dijkstra.timeRequiredforCompetition());
        assertEquals(15, dijkstra.graph.countEdges());

    }
    @Test
    public void testFloydTimeRequiredforCompetition() {
        CompetitionFloydWarshall floyd = new CompetitionFloydWarshall("tinyEWD.txt", 100, 100, 100);
        assertEquals(7, floyd.timeRequiredforCompetition());
    }
    @Test
    public void testDijkstraTimeRequiredforCompetitionNoMeetingPoints() {
        CompetitionDijkstra dijkstra = new CompetitionDijkstra(new Scanner("8\n" +
                "2\n" +
                "0 1 0.35\n" +
                "3 2 0.32\n"),
                100, 100, 100);
        assertEquals(-1, dijkstra.timeRequiredforCompetition());

    }
    @Test
    public void testFloydTimeTimeRequiredforCompetitionNoMeetingPoints() {
        CompetitionFloydWarshall floyd = new CompetitionFloydWarshall(new Scanner("8\n" +
                "2\n" +
                "0 1 0.35\n" +
                "3 2 0.32\n"),
                100, 100, 100);
        assertEquals(-1, floyd.timeRequiredforCompetition());

    }
}

package ConnectFour;

public interface Connect4GridInterface {
    void emptyGrid();
     String toString();
     boolean isValidColumn(int column);
     boolean isColumnFull(int column);
     void dropPiece(ConnectPlayer player, int column);
     boolean didLastPieceConnect4();
     boolean isGridFull();
}

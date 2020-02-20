package ConnectFour;

abstract public class ConnectPlayer {
    int value;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    private String type;
    public ConnectPlayer(int value) {
        this.value = value;
    }
    public abstract int placeCoinAtCol(Connect4GridInterface gameGrid);
}

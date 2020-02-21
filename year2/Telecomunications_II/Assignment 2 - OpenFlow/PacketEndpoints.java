package cs.tcd.ie;

public class PacketEndpoints {
    String sourceAddress;
    String destinationAddress;
    int sourcePort;
    int destinationPort;

    PacketEndpoints(String srcAddress, String destAddress, int srcPort, int dstPort ){
        this.sourceAddress = srcAddress;
        this.destinationAddress = destAddress;
        this.sourcePort = srcPort;
        this.destinationPort = dstPort;
    }

    @Override
    public String toString () {
        return this.sourceAddress + this.destinationAddress + this.sourcePort + this.destinationPort;
    }
}

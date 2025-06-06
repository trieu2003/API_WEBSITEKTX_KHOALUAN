public class CancelRepairRequest
{
    public string MaSV { get; set; }
    public int MaYCSC { get; set; }
}

public class CancelRepairResponse
{
    public bool Success { get; set; }
    public string Message { get; set; }
}
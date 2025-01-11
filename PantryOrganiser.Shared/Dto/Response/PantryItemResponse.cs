namespace PantryOrganiser.Shared.Dto.Response;

public class PantryItemResponse
{
    public Guid Id { get; set; }
    
    public string Name { get; set; }
    
    public string Description { get; set; }
    
    public int Quantity { get; set; }
    
    public string Brand { get; set; }
    
    public DateTime? ExpiryDate { get; set; }
}

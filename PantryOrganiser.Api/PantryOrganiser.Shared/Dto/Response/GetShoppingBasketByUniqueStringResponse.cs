namespace PantryOrganiser.Shared.Dto.Response;

public class GetShoppingBasketByUniqueStringResponse
{
    public Guid Id { get; set; }
    
    public string Name { get; set; }
    
    public string UniqueString { get; set; }
    
    public bool IsOwner { get; set; }
    
    public bool IsClosed { get; set; }
    
    public string OwnerName { get; set; }
}
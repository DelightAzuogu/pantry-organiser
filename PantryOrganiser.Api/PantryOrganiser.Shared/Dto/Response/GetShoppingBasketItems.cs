namespace PantryOrganiser.Shared.Dto.Response;

public class GetShoppingBasketItems
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    public int Quantity { get; set; }
    public string QuantityUnit { get; set; } 
    public bool IsChecked { get; set; } = false;
}

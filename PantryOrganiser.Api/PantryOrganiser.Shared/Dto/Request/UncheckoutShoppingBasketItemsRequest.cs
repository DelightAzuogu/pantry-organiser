namespace PantryOrganiser.Shared.Dto.Request;

public class UncheckoutShoppingBasketItemsRequest
{
    public Guid ShoppingBasketItemId { get; set; }
    
    public Guid ShoppingBasketId { get; set; }
}

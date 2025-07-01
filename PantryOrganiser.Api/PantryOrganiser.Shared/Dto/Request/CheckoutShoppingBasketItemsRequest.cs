namespace PantryOrganiser.Shared.Dto.Request;

public class CheckoutShoppingBasketItemsRequest
{
    public List<Guid> ShoppingBasketItemIds { get; set; }
    
    public Guid ShoppingBasketId { get; set; }
}

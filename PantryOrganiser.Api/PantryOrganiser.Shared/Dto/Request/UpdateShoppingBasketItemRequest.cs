using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Shared.Dto.Request;

public class UpdateShoppingBasketItemRequest
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    public int Quantity { get; set; }
    public QuantityUnit QuantityUnit { get; set; }
}

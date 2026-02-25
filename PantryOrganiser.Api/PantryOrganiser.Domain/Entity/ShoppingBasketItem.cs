using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Domain.Entity;

public class ShoppingBasketItem : BaseEntity
{
    public string Name { get; set; }
    public int Quantity { get; set; }
    public QuantityUnit QuantityUnit { get; set; }
    public Guid ShoppingBasketId { get; set; }
    public virtual ShoppingBasket ShoppingBasket { get; set; }
    public bool IsChecked { get; set; } = false;
}

namespace PantryOrganiser.Domain.Entity;

public class ShoppingBasketItem : BaseEntity
{
    public string Name { get; set; }
    public int Quantity { get; set; }
    public Guid ShoppingBasketId { get; set; }
    public virtual ShoppingBasket ShoppingBasket { get; set; }
    public Guid PantryItemId { get; set; }
    public virtual PantryItem PantryItem { get; set; }
}

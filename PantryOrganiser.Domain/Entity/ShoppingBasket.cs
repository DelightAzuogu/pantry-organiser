namespace PantryOrganiser.Domain.Entity;

public class ShoppingBasket : BaseEntity
{
    public string Name { get; set; }
    public virtual List<ShoppingBasketItem> ShoppingBasketItems { get; set; }
    public Guid UserId { get; set; }
    public virtual User User { get; set; }
}
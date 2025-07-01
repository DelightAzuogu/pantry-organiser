namespace PantryOrganiser.Domain.Entity;

public class ShoppingBasket : BaseEntity
{
    public string Name { get; set; }
    
    public bool IsClosed { get; set; } = false;
    
    public string UniqueString { get; set; } = Guid.NewGuid().ToString("N").Substring(0, 8);
    
    public virtual List<ShoppingBasketItem> ShoppingBasketItems { get; set; }

    public virtual List<ShoppingBasketUsers> ShoppingBasketUsers { get; set; }
}
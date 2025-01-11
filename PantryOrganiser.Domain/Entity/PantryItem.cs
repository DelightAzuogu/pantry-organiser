namespace PantryOrganiser.Domain.Entity;

public class PantryItem: BaseEntity
{
    public string Name { get; set; }
    public string Description { get; set; }
    public int Quantity { get; set; }
    public string Brand { get; set; }
    public Guid? PantryId { get; set; }
    public virtual Pantry Pantry { get; set; }
    public virtual List<ShoppingBasketItem> ShoppingBasketItems { get; set; }
}

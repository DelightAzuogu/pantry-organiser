using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Domain.Entity;

public class PantryItem: BaseEntity
{
    public string Name { get; set; }
    
    public string Description { get; set; }
    
    public double Quantity { get; set; }
    
    public QuantityUnit QuantityUnit { get; set; }
    
    public string Brand { get; set; }
    
    public DateTime? ExpiryDate { get; set; }
    
    public Guid PantryId { get; set; }
    public virtual Pantry Pantry { get; set; }
    
    public virtual List<ShoppingBasketItem> ShoppingBasketItems { get; set; }
}

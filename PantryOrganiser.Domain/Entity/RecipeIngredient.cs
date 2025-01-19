using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Domain.Entity;

public class RecipeIngredient : BaseEntity
{
    public Guid RecipeId { get; set; }
    public virtual Recipe Recipe { get; set; }
    
    public Guid PantryItemId { get; set; }
    public virtual PantryItem PantryItem { get; set; }
    
    public double Quantity { get; set; }
}

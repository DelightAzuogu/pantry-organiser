namespace PantryOrganiser.Domain.Entity;

public class Pantry : BaseEntity
{
    public string Name { get; set; }
    
    public virtual List<PantryItem> PantryItems { get; set; }
    
    public virtual List<PantryUser> PantryUsers { get; set; }
}

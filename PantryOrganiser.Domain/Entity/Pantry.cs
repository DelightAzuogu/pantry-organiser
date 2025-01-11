namespace PantryOrganiser.Domain.Entity;

public class Pantry : BaseEntity
{
    public string Name { get; set; }
    public virtual List<PantryItem> PantryItems { get; set; }
    public Guid UserId { get; set; }
    public virtual User User { get; set; }
}

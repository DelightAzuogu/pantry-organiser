namespace PantryOrganiser.Domain.Entity;

public class PantryUser : BaseEntity
{
    public Guid PantryId { get; set; }
    public virtual Pantry Pantry { get; set; }

    public Guid UserId { get; set; }
    public virtual User User { get; set; }

    public virtual List<PantryUserRole> PantryUserRoles { get; set; }
}

using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Domain.Entity;

public class PantryUserRole : BaseEntity
{
    public Guid PantryUserId { get; set; }
    public virtual PantryUser PantryUser { get; set; }

    public Role Role { get; set; }
}

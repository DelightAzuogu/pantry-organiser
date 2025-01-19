namespace PantryOrganiser.Domain.Entity;

public class RecipeUser : BaseEntity
{
    public Guid RecipeId { get; set; }
    public virtual Recipe Recipe { get; set; }

    public Guid UserId { get; set; }
    public virtual User User { get; set; }

    public bool IsOwner { get; set; }
}

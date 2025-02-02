namespace PantryOrganiser.Domain.Entity;

public class User : BaseEntity
{
    public string Email { get; set; }
    public string PasswordHash { get; set; }

    public virtual List<ShoppingBasket> ShoppingBaskets { get; set; }

    public virtual List<PantryUser> PantryUsers { get; set; }
    
    public virtual List<RecipeUser> RecipeUsers { get; set; }
}

namespace PantryOrganiser.Domain.Entity;

public class User : BaseEntity
{
    public string Email { get; set; }
    public string PasswordHash { get; set; }
    public virtual List<ShoppingBasket> ShoppingBaskets { get; set; }
    public virtual List<Pantry> Pantries { get; set; }
}

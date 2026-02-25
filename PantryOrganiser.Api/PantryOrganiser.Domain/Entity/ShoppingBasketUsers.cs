namespace PantryOrganiser.Domain.Entity;

public class ShoppingBasketUsers : BaseEntity
{
    public Guid UserId { get; set; }
    public virtual User User { get; set; }
    
    public Guid ShoppingBasketId { get; set; }
    public virtual ShoppingBasket ShoppingBasket { get; set; }

    public Boolean IsOwner { get; set; }
}

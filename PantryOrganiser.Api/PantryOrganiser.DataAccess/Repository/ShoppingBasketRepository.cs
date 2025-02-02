using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class ShoppingBasketRepository(AppDbContext dbContext) : BaseRepository<ShoppingBasket>(dbContext), IShoppingBasketRepository
{
    
}

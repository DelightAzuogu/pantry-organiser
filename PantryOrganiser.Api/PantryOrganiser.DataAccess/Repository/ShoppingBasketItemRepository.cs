using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class ShoppingBasketItemRepository(AppDbContext dbContext) : BaseRepository<ShoppingBasketItem>(dbContext), IShoppingBasketItemRepository
{
    
}

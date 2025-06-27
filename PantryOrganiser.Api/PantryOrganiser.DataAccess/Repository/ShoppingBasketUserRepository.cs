using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class ShoppingBasketUserRepository(AppDbContext dbContext) : BaseRepository<ShoppingBasketUsers>(dbContext), IShoppingBasketUserRepository
{
}

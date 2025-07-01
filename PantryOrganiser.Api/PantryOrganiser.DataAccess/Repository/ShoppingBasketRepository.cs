using Microsoft.EntityFrameworkCore;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class ShoppingBasketRepository(AppDbContext dbContext) : BaseRepository<ShoppingBasket>(dbContext), IShoppingBasketRepository
{
    public Task CreateAsync(ShoppingBasket shoppingBasket) => AddAsync(shoppingBasket);

    public Task<ShoppingBasket> GetShoppingBasketByIdAsync(Guid id) =>
        Query(x => x.Id == id)
            .FirstOrDefaultAsync();

    public Task<List<ShoppingBasket>> GetAllShoppingBasketsByUserIdAsync(Guid userId, bool? isClosed = null)
    {
        var query = Query(x => x.ShoppingBasketUsers.Any(y => y.UserId == userId));

        if (isClosed.HasValue) query = query.Where(x => x.IsClosed == isClosed.Value);

        return query.Select(x => new ShoppingBasket
            {
                Id = x.Id,
                Name = x.Name,
                CreatedAt = x.CreatedAt,
                UpdatedAt = x.UpdatedAt,
                UniqueString = x.UniqueString,
                DeletedAt = x.DeletedAt,
                IsClosed = x.IsClosed,
                ShoppingBasketUsers = x.ShoppingBasketUsers
                    .Where(y => y.UserId == userId)
                    .ToList()
            })
            .ToListAsync();
    }

    public Task DeleteBasketAsync(ShoppingBasket shoppingBasket) => DeleteAsync(shoppingBasket);

    public Task UpdateShoppingBasketAsync(ShoppingBasket shoppingBasket) => UpdateAsync(shoppingBasket);

    public Task<bool> DoesBasketWithIdExist(Guid basketId) => AnyAsync(x => x.Id == basketId);

    public Task<ShoppingBasket> GetShoppingBasketByUniqueStringAsync(string uniqueString) =>
        Query(x => x.UniqueString == uniqueString)
            .FirstOrDefaultAsync();
}

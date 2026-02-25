using Microsoft.EntityFrameworkCore;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class ShoppingBasketUserRepository(AppDbContext dbContext) : BaseRepository<ShoppingBasketUsers>(dbContext), IShoppingBasketUserRepository
{
    public Task<ShoppingBasketUsers> GetShoppingBasketUserByIdAsync(Guid id) =>
        Query(x => x.Id == id)
            .FirstOrDefaultAsync();

    public Task CreateAsync(ShoppingBasketUsers shoppingBasketUser) => AddAsync(shoppingBasketUser);

    public Task<bool> IsUserInShoppingBasketAsync(Guid basketId, Guid userId) =>
        AnyAsync(x => x.ShoppingBasketId == basketId && x.UserId == userId
        );

    public Task<bool> IsUserBasketOwnerAsync(Guid basketId, Guid userId) =>
        AnyAsync(x => x.ShoppingBasketId == basketId && x.UserId == userId && x.IsOwner
        );

    public async Task RemoveUserFromShoppingBasketAsync(Guid basketId, Guid userId)
    {
        var entity = await Query(x => x.ShoppingBasketId == basketId && x.UserId == userId)
            .FirstOrDefaultAsync();

        await DeleteAsync(entity);
    }

    public Task<List<ShoppingBasketUsers>> ReadShoppingBasketUsersAsync(Guid basketId) =>
        Query(x => x.ShoppingBasketId == basketId).Select(x => new ShoppingBasketUsers
        {
            Id = x.Id,
            CreatedAt = x.CreatedAt,
            UpdatedAt = x.UpdatedAt,
            DeletedAt = x.DeletedAt,
            UserId = x.UserId,
            User = x.User,
            IsOwner = x.IsOwner
        }).ToListAsync();
}

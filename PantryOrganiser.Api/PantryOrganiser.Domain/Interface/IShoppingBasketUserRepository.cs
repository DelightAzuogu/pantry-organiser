using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.Domain.Interface;

public interface IShoppingBasketUserRepository
{
    Task<ShoppingBasketUsers> GetShoppingBasketUserByIdAsync(Guid id);
    Task CreateAsync(ShoppingBasketUsers shoppingBasketUser);
    Task<bool> IsUserInShoppingBasketAsync(Guid basketId, Guid userId);

    Task<bool> IsUserBasketOwnerAsync(Guid basketId, Guid userId);
    Task RemoveUserFromShoppingBasketAsync(Guid basketId, Guid userId);
    
    Task<List<ShoppingBasketUsers>> ReadShoppingBasketUsersAsync(Guid basketId);
}

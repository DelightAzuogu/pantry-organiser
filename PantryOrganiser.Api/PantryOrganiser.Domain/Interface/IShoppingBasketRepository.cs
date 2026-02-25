using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.Domain.Interface;

public interface IShoppingBasketRepository
{
    Task CreateAsync(ShoppingBasket shoppingBasket);
    Task<ShoppingBasket> GetShoppingBasketByIdAsync(Guid id);
    Task<List<ShoppingBasket>> GetAllShoppingBasketsByUserIdAsync(Guid userId, bool? isClosed = null);
    Task DeleteBasketAsync(ShoppingBasket shoppingBasket);
    Task UpdateShoppingBasketAsync(ShoppingBasket shoppingBasket);
    Task<bool> DoesBasketWithIdExist(Guid basketId);
    Task<ShoppingBasket> GetShoppingBasketByUniqueStringAsync(string uniqueString);
}

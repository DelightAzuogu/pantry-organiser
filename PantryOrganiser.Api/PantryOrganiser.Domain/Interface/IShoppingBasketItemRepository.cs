using PantryOrganiser.Domain.Entity;

namespace PantryOrganiser.Domain.Interface;

public interface IShoppingBasketItemRepository
{
    Task AddItemAsync(ShoppingBasketItem shoppingBasketItem);
    Task<List<ShoppingBasketItem>> GetItemsByBasketIdAsync(Guid shoppingBasketId);
    Task CheckoutItemsAsync(Guid basketId, List<Guid> shoppingBasketItemIds);
    Task<ShoppingBasketItem> GetByIdAsync(Guid shoppingBasketItemId);
    Task DeleteItemAsync(ShoppingBasketItem shoppingBasketItem);
    Task UpdateItemAsync(ShoppingBasketItem shoppingBasketItem);
}
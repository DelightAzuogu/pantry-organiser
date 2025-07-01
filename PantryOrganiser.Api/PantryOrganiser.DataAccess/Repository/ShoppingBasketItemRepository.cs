using Microsoft.EntityFrameworkCore;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.DataAccess.Repository;

public class ShoppingBasketItemRepository(AppDbContext dbContext) : BaseRepository<ShoppingBasketItem>(dbContext), IShoppingBasketItemRepository
{
    public Task AddItemAsync(ShoppingBasketItem shoppingBasketItem) => AddAsync(shoppingBasketItem);

    public Task<List<ShoppingBasketItem>> GetItemsByBasketIdAsync(Guid shoppingBasketId) =>
        Query(x => x.ShoppingBasketId == shoppingBasketId)
            .ToListAsync();

    public Task CheckoutItemsAsync(Guid basketId, List<Guid> shoppingBasketItemIds) =>
        _context.ShoppingBasketItems.Where(x => x.ShoppingBasketId == basketId && shoppingBasketItemIds.Contains(x.Id))
            .ExecuteUpdateAsync(x => x.SetProperty(y => y.IsChecked, true));

    public Task<ShoppingBasketItem> GetByIdAsync(Guid shoppingBasketItemId) =>
        Query(x => x.Id == shoppingBasketItemId)
            .FirstOrDefaultAsync();

    public Task DeleteItemAsync(ShoppingBasketItem shoppingBasketItem) => DeleteAsync(shoppingBasketItem);
    public Task UpdateItemAsync(ShoppingBasketItem shoppingBasketItem) => UpdateAsync(shoppingBasketItem);
}

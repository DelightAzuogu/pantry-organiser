using Microsoft.EntityFrameworkCore;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Shared.Dto.Request;

namespace PantryOrganiser.DataAccess.Repository;

public class PantryItemRepository(AppDbContext dbContext) : BaseRepository<PantryItem>(dbContext), IPantryItemRepository
{
    public async Task DeletePantryItemsByPantryIdAsync(Guid pantryId)
    {
        var items = await Query(x => x.PantryId == pantryId).ToListAsync();

        await DeleteRangeAsync(items);
    }

    public Task AddPantryItemAsync(PantryItem pantryItem) => AddAsync(pantryItem);

    public Task<Guid> GetPantryIdByItemIdAsync(Guid itemId) =>
        Query(x => x.Id == itemId)
            .Select(x => x.PantryId).FirstOrDefaultAsync();

    public Task<PantryItem> GetPantryItemByIdAsync(Guid itemId) =>
        Query(x => x.Id == itemId)
            .FirstOrDefaultAsync();

    public Task<List<PantryItem>> GetPantryItemsByPantryIdAsync(Guid pantryId) =>
        Query(x => x.PantryId == pantryId)
            .ToListAsync();

    public async Task UpdatePantryItemAsync(Guid pantryItemId, UpdatePantryItemRequest request)
    {
        var pantryItem = await Query(x => x.Id == pantryItemId).SingleAsync();

        pantryItem.Name = request.Name;
        pantryItem.Description = request.Description;
        pantryItem.Quantity = request.Quantity;
        pantryItem.Brand = request.Brand;
        pantryItem.ExpiryDate = request.ExpiryDate;

        await UpdateAsync(pantryItem);
    }

    public async Task DeletePantryItemAsync(Guid pantryItemId)
    {
        var pantryItem = await Query(x => x.Id == pantryItemId).SingleAsync();

        await DeleteAsync(pantryItem);
    }

    public Task<bool> PantryItemWithIdExistsAsync(Guid itemId) => AnyAsync(x => x.Id == itemId);
}

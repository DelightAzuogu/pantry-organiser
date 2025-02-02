using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Shared.Dto.Request;

namespace PantryOrganiser.Domain.Interface;

public interface IPantryItemRepository
{
    public Task DeletePantryItemsByPantryIdAsync(Guid pantryId);

    public Task AddPantryItemAsync(PantryItem pantryItem);

    public Task<bool> PantryItemWithIdExistsAsync(Guid itemId);

    public Task<Guid> GetPantryIdByItemIdAsync(Guid itemId);
    
    public Task<PantryItem> GetPantryItemByIdAsync(Guid itemId);
    
    Task<List<PantryItem>> GetPantryItemsByPantryIdAsync(Guid pantryId);
    
    Task UpdatePantryItemAsync(Guid pantryItemId, UpdatePantryItemRequest request);
    
    Task DeletePantryItemAsync(Guid pantryItemId);
}

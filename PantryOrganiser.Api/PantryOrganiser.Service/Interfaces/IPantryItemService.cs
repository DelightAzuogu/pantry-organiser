using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Service.Interfaces;

public interface IPantryItemService
{
    Task<Guid> AddPantryItemAsync(CreatePantryItemRequest request, Guid pantryId, Guid userId);
    
    Task<PantryItemResponse> GetPantryItemAsync(Guid pantryItemId, Guid userId);
    
    Task<List<PantryItemResponse>> GetItemsInAPantryAsync(Guid pantryId, Guid userId);
    
    Task UpdatePantryItemAsync(Guid pantryItemId, UpdatePantryItemRequest request, Guid userId);
    
    Task DeletePantryItemAsync(Guid pantryItemId, Guid userId);
    
    Task ValidatePantryItemPantryRoleAsync(Guid pantryItemId, Guid userId, Role role);
    
    Task ValidatePantryItemExistenceAsync(Guid pantryItemId);
}

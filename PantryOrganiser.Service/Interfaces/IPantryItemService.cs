using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;

namespace PantryOrganiser.Service.Interfaces;

public interface IPantryItemService
{
    Task<Guid> AddPantryItemAsync(CreatePantryItemRequest request, Guid pantryId, Guid userId);

    Task<PantryItemResponse> GetPantryItemAsync(Guid pantryItemId, Guid userId);

    Task<List<PantryItemResponse>> GetItemsInAPantryAsync(Guid pantryId, Guid userId);

    Task UpdatePantryItemAsync(Guid pantryItemId, UpdatePantryItemRequest request, Guid userId);

    Task DeletePantryItemAsync(Guid pantryItemId, Guid userId);

    Task ValidatePantryItemOwnershipAsync(Guid pantryItemId, Guid userId);

    Task ValidatePantryItemExistenceAsync(Guid pantryItemId);
}

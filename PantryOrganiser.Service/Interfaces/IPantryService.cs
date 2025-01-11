using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;

namespace PantryOrganiser.Service.Interfaces;

public interface IPantryService
{
    Task<Guid> CreatePantryAsync(string name, Guid userId);

    Task<List<PantryDto>> GetPantriesByUserIdAsync(Guid userId);

    Task ValidatePantryExistenceByIdAsync(Guid pantryId);

    Task DeletePantryByIdAsync(Guid pantryId, Guid userId);

    Task UpdatePantryAsync(UpdatePantryRequest request, Guid userId);
}

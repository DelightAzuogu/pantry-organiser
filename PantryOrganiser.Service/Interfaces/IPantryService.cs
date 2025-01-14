using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Service.Interfaces;

public interface IPantryService
{
    Task<Guid> CreatePantryAsync(string name, Guid userId);

    Task<List<PantryDto>> GetPantriesByUserIdAsync(Guid userId);

    Task DeletePantryByIdAsync(Guid pantryId, Guid userId);

    Task UpdatePantryAsync(UpdatePantryRequest request, Guid userId);

    Task ValidateUserPantryRole(Guid userId, Guid pantryId, Role role);

    Task ValidatePantryExistenceByIdAsync(Guid pantryId);
}

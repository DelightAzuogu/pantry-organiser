using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Shared.Dto.Response;

namespace PantryOrganiser.Domain.Interface;

public interface IPantryRepository
{
    Task CreatePantryAsync(Pantry pantry);

    Task<List<PantryDto>> GetPantriesByUserIdAsync(Guid userId);

    Task DeletePantryAsync(Guid pantryId);

    Task<bool> PantryWithIdExistAsync(Guid pantryId);

    Task<Pantry> GetPantryByIdAsync(Guid pantryId);
    
    Task UpdatePantryAsync(Guid pantryId, string name);
}

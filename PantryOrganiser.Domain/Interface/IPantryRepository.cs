using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Shared.Dto.Response;

namespace PantryOrganiser.Domain.Interface;

public interface IPantryRepository
{
    public Task CreatePantryAsync(Pantry pantry);

    public Task<List<PantryDto>> GetPantriesByUserIdAsync(Guid userId);
    
    public Task DeletePantryAsync(Guid pantryId);

    public Task<bool> PantryWithIdExistAsync(Guid pantryId);

    public Task<Pantry> GetPantryByIdAsync(Guid pantryId);
}

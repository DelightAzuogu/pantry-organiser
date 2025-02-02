using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Domain.Interface;

public interface IPantryUserRepository
{
    Task CreateAsync(PantryUser pantryUser);
    
    Task<List<Guid>> GetUserPantriesIdsAsync(Guid userId);
    
    Task<PantryUser> GetPantryUserByUserIdAndPantryIdAsync(Guid userId, Guid pantryId);
   
    Task<bool> PantryUserWithPantryIdAndUserIdExistsAsync(Guid pantryId, Guid userId);
    
    Task<bool> PantryUserWithIdExistAsync(Guid pantryUserId);
    
    Task<PantryUser> GetByIdAsync(Guid pantryUserId);
    
    Task DeletePantryUserWithIdAsync(PantryUser pantryUser);
    
    Task<List<PantryUser>> GetPantryUsersByPantryIdAsync(Guid pantryId);
}

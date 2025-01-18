using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Shared.Dto;
using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;

namespace PantryOrganiser.Service.Interfaces;

public interface IPantryUserService
{
    Task AddUserToPantryAsync(AddUserToPantryRequest request, Guid pantryId, Guid userId);

    Task RemoveUserFromPantryAsync(Guid pantryUserId, Guid userId);

    Task ValidateUserExistsInPantryAsync(Guid pantryId, Guid userId);

    Task ValidateUserDoesNotExistInPantryAsync(Guid pantryId, Guid userId);

    Task<PantryUser> GetPantryUserAsync(Guid pantryUserId);

    Task AddRolesToUserInPantryAsync(AddRolesToUserInPantryRequest request, Guid pantryUserId, Guid userId);
    
    Task<List<PantryUserResponse>> GetPantryUsersByPantryIdAsync(Guid pantryId, Guid userId);
}

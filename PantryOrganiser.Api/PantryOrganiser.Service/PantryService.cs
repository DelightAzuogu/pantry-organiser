using Microsoft.Extensions.Logging;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;
using PantryOrganiser.Shared.Enum;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Service;

public class PantryService(
    ILogger<PantryService> logger,
    IPantryRepository pantryRepository,
    IPantryItemRepository pantryItemRepository,
    IUserService userService,
    IPantryUserRepository pantryUserRepository,
    IPantryUserRoleRepository pantryUserRoleRepository
) : IPantryService
{
    public async Task<Guid> CreatePantryAsync(string name, Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);

        logger.LogInformation("Creating pantry with name {Name} for user with id {UserId}", name, userId);
        var pantry = new Pantry
        {
            Name = name
        };

        await pantryRepository.CreatePantryAsync(pantry);

        logger.LogInformation("Creating pantry user with pantry id {PantryId} and user id {UserId}", pantry.Id, userId);

        var pantryUser = new PantryUser
        {
            PantryId = pantry.Id,
            UserId = userId
        };

        await pantryUserRepository.CreateAsync(pantryUser);

        logger.LogInformation("Creating pantry user role as owner with pantry id {PantryId} and user id {UserId}", pantry.Id, userId);

        var pantryUserRole = new PantryUserRole
        {
            PantryUserId = pantryUser.Id,
            Role = Role.Owner
        };

        await pantryUserRoleRepository.CreateAsync(pantryUserRole);

        return pantry.Id;
    }

    public async Task<List<PantryDto>> GetPantriesByUserIdAsync(Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);

        logger.LogInformation("Getting pantries for user with id {UserId}", userId);

        var pantryIds = await pantryUserRepository.GetUserPantriesIdsAsync(userId);

        return await pantryRepository.GetPantriesAsync(pantryIds);
    }

    public async Task DeletePantryByIdAsync(Guid pantryId, Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);

        await ValidatePantryExistenceByIdAsync(pantryId);

        await ValidateUserPantryRole(userId, pantryId, Role.Delete);

        logger.LogInformation("Deleting pantry with id {PantryId}", pantryId);
        await pantryRepository.DeletePantryAsync(pantryId);
        
        logger.LogInformation("Deleting pantry items with pantry id {PantryId}", pantryId);
        await pantryItemRepository.DeletePantryItemsByPantryIdAsync(pantryId);
    }

    public async Task UpdatePantryAsync(UpdatePantryRequest request, Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);

        await ValidatePantryExistenceByIdAsync(request.PantryId);

        await ValidateUserPantryRole(userId, request.PantryId, Role.Update);

        logger.LogInformation("Updating pantry with id {PantryId} for user with id {UserId}", request.PantryId, userId);

        await pantryRepository.UpdatePantryAsync(request.PantryId, request.Name);
    }

    public async Task ValidateUserPantryRole(Guid userId, Guid pantryId, Role role)
    {
        logger.LogInformation("Validating user role with id {UserId} for pantry with id {PantryId}", userId, pantryId);

        var pantryUser = await pantryUserRepository.GetPantryUserByUserIdAndPantryIdAsync(userId, pantryId);

        if (pantryUser == null)
        {
            logger.LogError("User with id {UserId} does not have a pantry with id {PantryId}", userId, pantryId);
            throw new PantryUserNotFoundException($"User {userId} does not have a pantry {pantryId}");
        }

        if (!await pantryUserRoleRepository.PantryUserWithRoleExistAsync(pantryUser.Id, role))
        {
            logger.LogError("User with id {UserId} does not have role {Role} in pantry with id {PantryId}", userId, role, pantryId);
            throw new PantryRoleNotFoundException($"User {userId} does not have role {role} in pantry {pantryId}");
        }
    }

    public async Task ValidatePantryExistenceByIdAsync(Guid pantryId)
    {
        logger.LogInformation("Validating pantry existence with id {PantryId}", pantryId);

        if (!await pantryRepository.PantryWithIdExistAsync(pantryId))
        {
            logger.LogError("Pantry with id {PantryId} does not exist", pantryId);
            throw new PantryNotFoundException($"Pantry {pantryId} not found");
        }

        logger.LogInformation("Pantry with id {PantryId} exists", pantryId);
    }
}

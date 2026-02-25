using Microsoft.Extensions.Logging;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Dto;
using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;
using PantryOrganiser.Shared.Enum;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Service;

public class PantryUserService(
    ILogger<PantryUserService> logger,
    IPantryUserRepository pantryUserRepository,
    IPantryUserRoleRepository pantryUserRoleRepository,
    IUserService userService,
    IPantryService pantryService
) : IPantryUserService
{
    public async Task AddUserToPantryAsync(AddUserToPantryRequest request, Guid pantryId, Guid userId)
    {
        var user = await userService.GetUserByIdAsync(userId);

        var userToAdd = await userService.GetUserByEmailAsync(request.Email);

        await ValidateUserDoesNotExistInPantryAsync(pantryId, userToAdd.Id);

        await pantryService.ValidateUserPantryRole(userId, pantryId, Role.Owner);

        logger.LogInformation("Adding user with id {UserId} to pantry with id {PantryId}", userToAdd.Id, pantryId);
        var pantryUser = new PantryUser
        {
            UserId = userToAdd.Id,
            PantryId = pantryId
        };
        await pantryUserRepository.CreateAsync(pantryUser);

        logger.LogInformation("User with id {UserId} added to pantry with id {PantryId}", userToAdd.Id, pantryId);

        logger.LogInformation("Adding user roles");

        var pantryUserRoles = request.Roles.Select(role => new PantryUserRole
        {
            PantryUserId = pantryUser.Id,
            Role = role
        }).ToList();
        await pantryUserRoleRepository.AddUserRolesAsync(pantryUserRoles);

        logger.LogInformation("User roles added");
    }

    public async Task RemoveUserFromPantryAsync(Guid pantryUserId, Guid userId)
    {
        logger.LogInformation("validating pantry user with id {PantryUserId}", pantryUserId);

        var pantryUser = await GetPantryUserAsync(pantryUserId);

        await pantryService.ValidateUserPantryRole(userId, pantryUser.PantryId, Role.Owner);

        logger.LogInformation("Deleting pantry user with id {PantryUserId}", pantryUserId);
        await pantryUserRepository.DeletePantryUserWithIdAsync(pantryUser);

        logger.LogInformation("deleting pantry user roles");
        await pantryUserRoleRepository.DeleteUserRolesByPantryUserIdAsync(pantryUserId);
    }

    public async Task AddRolesToUserInPantryAsync(AddRolesToUserInPantryRequest request, Guid pantryUserId, Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);

        logger.LogInformation("Validating pantry user with id {PantryUserId}", pantryUserId);

        var pantryUser = await GetPantryUserAsync(pantryUserId);

        await pantryService.ValidateUserPantryRole(userId, pantryUser.PantryId, Role.Owner);

        logger.LogInformation("Deleting all pantry roles for pantry user with id {PantryUserId}", pantryUserId);
        await pantryUserRoleRepository.DeleteUserRolesByPantryUserIdAsync(pantryUserId);
        
        logger.LogInformation("Adding roles to user with id {PantryUserId}", pantryUserId);

        var pantryUserRoles = request.Roles.Select(role => new PantryUserRole
        {
            PantryUserId = pantryUserId,
            Role = role
        }).ToList();

        await pantryUserRoleRepository.AddUserRolesAsync(pantryUserRoles);

        logger.LogInformation("Roles added to user with id {PantryUserId}", pantryUserId);
    }

    public async Task<List<PantryUserResponse>> GetPantryUsersByPantryIdAsync(Guid pantryId, Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);

        await pantryService.ValidatePantryExistenceByIdAsync(pantryId);

        await pantryService.ValidateUserPantryRole(userId, pantryId, Role.Owner);

        logger.LogInformation("Getting pantry users for pantry with id {PantryId}", pantryId);

        var pantryUsers = await pantryUserRepository.GetPantryUsersByPantryIdAsync(pantryId);

        return pantryUsers
            .Where(x => x.UserId != userId)
            .Select(x => new PantryUserResponse
            {
                UserId = x.UserId,
                PantryUserId = x.Id,
                Email = x.User.Email,
                Roles = x.PantryUserRoles.Select(y => y.Role).ToList()
            }).ToList();
    }

    public async Task<PantryUser> GetPantryUserAsync(Guid pantryUserId)
    {
        logger.LogInformation("Getting pantry user with id {PantryUserId}", pantryUserId);

        var pantryUser = await pantryUserRepository.GetByIdAsync(pantryUserId);
        if (pantryUser is null)
        {
            logger.LogError("Pantry user with id {PantryUserId} does not exist", pantryUserId);
            throw new PantryUserNotFoundException($"Pantry user with id {pantryUserId} does not exist");
        }

        logger.LogInformation("Pantry user with id {PantryUserId} found", pantryUserId);
        return pantryUser;
    }

    public async Task ValidateUserExistsInPantryAsync(Guid pantryId, Guid userId)
    {
        logger.LogInformation("Validating pantry user with pantry id {PantryId} and user id {UserId}", pantryId, userId);

        if (!await pantryUserRepository.PantryUserWithPantryIdAndUserIdExistsAsync(pantryId, userId))
        {
            logger.LogError("Pantry user with pantry id {PantryId} and user id {UserId} does not exist", pantryId, userId);
            throw new PantryUserNotFoundException($"Pantry user with pantry id {pantryId} and user id {userId} does not exist");
        }

        logger.LogInformation("Pantry user with pantry id {PantryId} and user id {UserId} exists", pantryId, userId);
    }

    public async Task ValidateUserDoesNotExistInPantryAsync(Guid pantryId, Guid userId)
    {
        logger.LogInformation("Validating pantry user with pantry id {PantryId} and user id {UserId} Exist", pantryId, userId);

        if (await pantryUserRepository.PantryUserWithPantryIdAndUserIdExistsAsync(pantryId, userId))
        {
            logger.LogError("Pantry user with pantry id {PantryId} and user id {UserId} exist", pantryId, userId);
            throw new PantryUserExistsException($"Pantry user with pantry id {pantryId} and user id {userId} exist");
        }

        logger.LogInformation("Pantry user with pantry id {PantryId} and user id {UserId} does not exists", pantryId, userId);
    }
}

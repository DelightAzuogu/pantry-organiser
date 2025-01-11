using Microsoft.Extensions.Logging;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Dto.Response;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Service;

public class PantryService(ILogger<PantryService> logger, IPantryRepository pantryRepository, IPantryItemRepository pantryItemRepository, IUserService userService) : IPantryService
{
    public async Task<Guid> CreatePantryAsync(string name, Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);
        
        logger.LogInformation("Creating pantry with name {Name} for user with id {UserId}", name, userId);
        var pantry = new Pantry
        {
            Name = name,
            UserId = userId,
        };
        
        await pantryRepository.CreatePantryAsync(pantry);
        
        logger.LogInformation("Pantry with name {Name} created for user with id {UserId}", name, userId);
        
        return pantry.Id;
    }
    
    public async Task<List<PantryDto>> GetPantriesByUserIdAsync(Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);
        
        logger.LogInformation("Getting pantries for user with id {UserId}", userId);
        
        return await pantryRepository.GetPantriesByUserIdAsync(userId);
    }

    public async Task DeletePantryByIdAsync(Guid pantryId, Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);
        
        logger.LogInformation("Deleting pantry with id {PantryId} for user with id {UserId}", pantryId, userId);
        
        await ValidatePantryExistenceByIdAsync(pantryId);
        
        var pantry = await pantryRepository.GetPantryByIdAsync(pantryId);

        if (pantry.UserId != userId)
        {
            logger.LogError("User with id {UserId} does not own pantry with id {PantryId}", userId, pantryId);
            throw new PantryOwnershipException($"User {userId} does not own pantry {pantryId}");
        }
        
        logger.LogInformation("Deleting pantry with id {PantryId}", pantryId);
        await pantryRepository.DeletePantryAsync(pantryId);
        
        logger.LogInformation("Deleting pantry items with pantry id {PantryId}", pantryId);
        await pantryItemRepository.DeletePantryItemsByPantryIdAsync(pantryId);
    }
    
    public async Task ValidatePantryExistenceByIdAsync(Guid pantryId)
    {
        logger.LogInformation("Validating pantry existence with id {PantryId}", pantryId);
        
        if(!await pantryRepository.PantryWithIdExistAsync(pantryId))
        {
            logger.LogError("Pantry with id {PantryId} does not exist", pantryId);
            throw new PantryNotFoundException($"Pantry {pantryId} not found");
        }
        
        logger.LogInformation("Pantry with id {PantryId} exists", pantryId);
    }
    
    
}

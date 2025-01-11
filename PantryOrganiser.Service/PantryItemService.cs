using Microsoft.Extensions.Logging;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Service;

public class PantryItemService(ILogger<PantryService> logger, IPantryService pantryService, IPantryItemRepository pantryItemRepository) : IPantryItemService
{
    public async Task<Guid> AddPantryItemAsync(CreatePantryItemRequest request,Guid pantryId, Guid userId)
    {
        await pantryService.ValidatePantryOwnershipAsync(pantryId, userId);

        logger.LogInformation("Creating pantry item {item}", request.ToString());
        var pantryItem = new PantryItem
        {
            Name = request.Name,
            Quantity = request.Quantity,
            PantryId = pantryId,
            ExpiryDate = request.ExpiryDate,
            Description = request.Description,
            Brand = request.Brand
        };

        await pantryItemRepository.AddPantryItemAsync(pantryItem);

        return pantryItem.PantryId;
    }

    public async Task<PantryItemResponse> GetPantryItemAsync(Guid pantryItemId, Guid userId)
    {
        await ValidatePantryItemOwnershipAsync(pantryItemId, userId);

        logger.LogInformation("Getting pantry item {pantryItemId}", pantryItemId);

        var pantryItem = await pantryItemRepository.GetPantryItemByIdAsync(pantryItemId);

        return new PantryItemResponse
        {
            Id = pantryItem.Id,
            Name = pantryItem.Name,
            Quantity = pantryItem.Quantity,
            ExpiryDate = pantryItem.ExpiryDate,
            Description = pantryItem.Description,
            Brand = pantryItem.Brand
        };
    }

    public async Task<List<PantryItemResponse>> GetItemsInAPantryAsync(Guid pantryId, Guid userId)
    {
        await pantryService.ValidatePantryOwnershipAsync(pantryId, userId);

        logger.LogInformation("Getting pantry items for pantry {pantryId}", pantryId);
        var pantryItems = await pantryItemRepository.GetPantryItemsByPantryIdAsync(pantryId);

        return pantryItems.Select(pantryItem => new PantryItemResponse
        {
            Id = pantryItem.Id,
            Name = pantryItem.Name,
            Quantity = pantryItem.Quantity,
            ExpiryDate = pantryItem.ExpiryDate,
            Description = pantryItem.Description,
            Brand = pantryItem.Brand
        }).ToList();
    }

    public async Task UpdatePantryItemAsync(Guid pantryItemId, UpdatePantryItemRequest request, Guid userId)
    {
        await ValidatePantryItemOwnershipAsync(pantryItemId, userId);

        logger.LogInformation("Updating pantry item {pantryItemId} with {request}", pantryItemId, request.ToString());

        await pantryItemRepository.UpdatePantryItemAsync(pantryItemId, request);
    }

    public async Task DeletePantryItemAsync(Guid pantryItemId, Guid userId)
    {
        await ValidatePantryItemOwnershipAsync(pantryItemId, userId);

        logger.LogInformation("Deleting pantry item {pantryItemId}", pantryItemId);
        await pantryItemRepository.DeletePantryItemAsync(pantryItemId);
    }

    public async Task ValidatePantryItemOwnershipAsync(Guid pantryItemId, Guid userId)
    {
        await ValidatePantryItemExistenceAsync(pantryItemId);

        logger.LogInformation("Getting pantry id for pantry item {pantryItemId}", pantryItemId);
        var pantryId = await pantryItemRepository.GetPantryIdByItemIdAsync(pantryItemId);

        await pantryService.ValidatePantryOwnershipAsync(pantryId, userId);
    }

    public async Task ValidatePantryItemExistenceAsync(Guid pantryItemId)
    {
        logger.LogInformation("Validating pantry item existence {pantryItemId}", pantryItemId);
        if (!await pantryItemRepository.PantryItemWithIdExistsAsync(pantryItemId))
        {
            logger.LogError("Pantry item with id {pantryItemId} does not exist", pantryItemId);
            throw new PantryItemNotFoundException();
        }
    }
}

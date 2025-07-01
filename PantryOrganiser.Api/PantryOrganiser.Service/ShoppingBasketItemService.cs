using Microsoft.Extensions.Logging;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Service;

public class ShoppingBasketItemService(
    IShoppingBasketItemRepository shoppingBasketItemRepository,
    IShoppingBasketUserRepository shoppingBasketUserRepository,
    IShoppingBasketRepository shoppingBasketRepository,
    ILogger<ShoppingBasketItemService> logger,
    IUserContext userContext
) : IShoppingBasketItemService
{
    public async Task AddItemToBasketAsync(AddShoppingBasketItem request)
    {
        logger.LogInformation("Adding item to Basket");

        var isUserBasketOwner = await shoppingBasketUserRepository.IsUserBasketOwnerAsync(
            userContext.UserId, request.ShoppingBasketId);

        if (!isUserBasketOwner)
        {
            logger.LogWarning("User {UserId} is not the owner of the shopping basket {ShoppingBasketId}",
                userContext.UserId, request.ShoppingBasketId);
            throw new UnauthorizedAccessException("User is not the owner of the shopping basket.");
        }

        var doesBasketExist = await shoppingBasketRepository.DoesBasketWithIdExist(request.ShoppingBasketId);
        if (!doesBasketExist)
        {
            logger.LogWarning("Shopping basket with ID {ShoppingBasketId} does not exist", request.ShoppingBasketId);
            throw new ShoppingBasketNotFoundException("Shopping basket not found.");
        }

        var shoppingBasketItem = new ShoppingBasketItem
        {
            Name = request.Name,
            Quantity = request.Quantity,
            QuantityUnit = request.QuantityUnit,
            ShoppingBasketId = request.ShoppingBasketId
        };
        await shoppingBasketItemRepository.AddItemAsync(shoppingBasketItem);
    }

    public async Task<List<GetShoppingBasketItems>> GetItemsByBasketIdAsync(Guid shoppingBasketId)
    {
        logger.LogInformation("Checking if user is in shopping basket {ShoppingBasketId}", shoppingBasketId);
        var isUserInBasket = await shoppingBasketUserRepository.IsUserInShoppingBasketAsync(shoppingBasketId, userContext.UserId);
        if (!isUserInBasket)
        {
            logger.LogWarning("User {UserId} is not in the shopping basket {ShoppingBasketId}", userContext.UserId, shoppingBasketId);
            throw new UnauthorizedAccessException("User is not in the shopping basket.");
        }

        logger.LogInformation("Retrieving items for shopping basket {ShoppingBasketId}", shoppingBasketId);
        var basketItems = await shoppingBasketItemRepository.GetItemsByBasketIdAsync(shoppingBasketId);

        if (basketItems == null || !basketItems.Any())
        {
            logger.LogInformation("No items found for shopping basket {ShoppingBasketId}", shoppingBasketId);
            return new List<GetShoppingBasketItems>();
        }

        logger.LogInformation("Found {ItemCount} items for shopping basket {ShoppingBasketId}", basketItems.Count, shoppingBasketId);
        return basketItems.Select(item => new GetShoppingBasketItems
        {
            Id = item.Id,
            Name = item.Name,
            Quantity = item.Quantity,
            QuantityUnit = item.QuantityUnit.ToString(),
            IsChecked = item.IsChecked
        }).ToList();
    }

    public async Task CheckoutShoppingBasketItemsAsync(CheckoutShoppingBasketItemsRequest request)
    {
        logger.LogInformation("Checking out items for shopping basket {ShoppingBasketId}", request.ShoppingBasketId);

        var isUserInBasket = await shoppingBasketUserRepository.IsUserInShoppingBasketAsync(userContext.UserId, request.ShoppingBasketId);

        if (!isUserInBasket)
        {
            logger.LogWarning("User {UserId} is part of the shopping basket {ShoppingBasketId}", userContext.UserId, request.ShoppingBasketId);
            throw new UnauthorizedAccessException("User is not part of the shopping basket of the shopping basket.");
        }

        var doesBasketExist = await shoppingBasketRepository.DoesBasketWithIdExist(request.ShoppingBasketId);
        if (!doesBasketExist)
        {
            logger.LogWarning("Shopping basket with ID {ShoppingBasketId} does not exist", request.ShoppingBasketId);
            throw new ShoppingBasketNotFoundException("Shopping basket not found.");
        }

        logger.LogInformation("Checking out items with IDs {ShoppingBasketItemIds} from shopping basket {ShoppingBasketId}",
            string.Join(", ", request.ShoppingBasketItemIds), request.ShoppingBasketId);
        await shoppingBasketItemRepository.CheckoutItemsAsync(request.ShoppingBasketId, request.ShoppingBasketItemIds);
    }

    public async Task DeleteShoppingBasketItemAsync(Guid shoppingBasketItemId)
    {
        logger.LogInformation("Deleting shopping basket item with ID {ShoppingBasketItemId}", shoppingBasketItemId);

        var shoppingBasketItem = await shoppingBasketItemRepository.GetByIdAsync(shoppingBasketItemId);
        if (shoppingBasketItem == null)
        {
            logger.LogWarning("Shopping basket item with ID {ShoppingBasketItemId} does not exist", shoppingBasketItemId);
            throw new ShoppingBasketItemNotFoundException("Shopping basket item not found.");
        }

        var isUserBasketOwner = await shoppingBasketUserRepository.IsUserBasketOwnerAsync(userContext.UserId, shoppingBasketItem.ShoppingBasketId);
        if (!isUserBasketOwner)
        {
            logger.LogError("User {UserId} is not the owner of the shopping basket for item {ShoppingBasketItemId}",
                userContext.UserId, shoppingBasketItemId);
            throw new UnauthorizedAccessException("User is not the owner of the shopping basket.");
        }

        await shoppingBasketItemRepository.DeleteItemAsync(shoppingBasketItem);
        logger.LogInformation("Deleted shopping basket item with ID {ShoppingBasketItemId}", shoppingBasketItemId);
    }

    public async Task UpdateShoppingBasketItemAsync(UpdateShoppingBasketItemRequest request)
    {
        logger.LogInformation("Updating shopping basket item with ID {ShoppingBasketItemId}", request.Id);

        var shoppingBasketItem = await shoppingBasketItemRepository.GetByIdAsync(request.Id);
        if (shoppingBasketItem == null)
        {
            logger.LogWarning("Shopping basket item with ID {ShoppingBasketItemId} does not exist", request.Id);
            throw new ShoppingBasketItemNotFoundException("Shopping basket item not found.");
        }

        var isUserBasketOwner = await shoppingBasketUserRepository.IsUserBasketOwnerAsync(userContext.UserId, shoppingBasketItem.ShoppingBasketId);
        if (!isUserBasketOwner)
        {
            logger.LogError("User {UserId} is not the owner of the shopping basket for item {ShoppingBasketItemId}",
                userContext.UserId, request.Id);
            throw new UnauthorizedAccessException("User is not the owner of the shopping basket.");
        }

        shoppingBasketItem.Name = request.Name;
        shoppingBasketItem.Quantity = request.Quantity;
        shoppingBasketItem.QuantityUnit = request.QuantityUnit;

        await shoppingBasketItemRepository.UpdateItemAsync(shoppingBasketItem);
        logger.LogInformation("Updated shopping basket item with ID {ShoppingBasketItemId}", request.Id);
    }
}

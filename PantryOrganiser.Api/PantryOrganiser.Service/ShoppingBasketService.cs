using Microsoft.Extensions.Logging;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Dto.Response;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Service;

public class ShoppingBasketService(
    ILogger<ShoppingBasketService> logger,
    IUserContext userContext,
    IShoppingBasketUserRepository shoppingBasketUserRepository,
    IShoppingBasketRepository shoppingBasketRepository
) : IShoppingBasketService
{
    public async Task CreateShoppingBasketAsync(string name)
    {
        if (string.IsNullOrWhiteSpace(name))
        {
            logger.LogError("Shopping basket name cannot be null or empty.");
            throw new ArgumentException("Shopping basket name cannot be null or empty.", nameof(name));
        }

        logger.LogInformation($"Creating shopping basket for user with ID: {userContext.UserId}");

        var shoppingBasket = new ShoppingBasket
        {
            Name = name
        };

        await shoppingBasketRepository.CreateAsync(shoppingBasket);
        logger.LogInformation($"Shopping basket created for user with ID: {userContext.UserId}");


        logger.LogInformation($"Creating shopping basket for user with ID: {userContext.UserId}");
        var shoppingBasketUser = new ShoppingBasketUsers
        {
            UserId = userContext.UserId,
            ShoppingBasketId = shoppingBasket.Id,
            IsOwner = true
        };

        await shoppingBasketUserRepository.CreateAsync(shoppingBasketUser);
    }

    public async Task<GetShoppingBasketResponse> GetShoppingBasketAsync(Guid id)
    {
        logger.LogInformation("Checking if user is authorized to access the shopping basket.");
        var isUserInBasket = await shoppingBasketUserRepository.IsUserInShoppingBasketAsync(id, userContext.UserId);

        if (!isUserInBasket)
        {
            logger.LogError($"User with ID {userContext.UserId} is not authorized to access shopping basket with ID {id}.");
            throw new UnauthorizedAccessException($"User with ID {userContext.UserId} is not authorized to access this shopping basket.");
        }

        logger.LogInformation($"Getting shopping basket by ID: {id}");
        var shoppingBasket = await shoppingBasketRepository.GetShoppingBasketByIdAsync(id);

        if (shoppingBasket == null)
        {
            logger.LogError($"Shopping basket with ID {id} not found.");
            throw new KeyNotFoundException($"Shopping basket with ID {id} not found.");
        }

        logger.LogInformation($"Shopping basket with ID {id} retrieved successfully.");


        return new GetShoppingBasketResponse
        {
            Id = shoppingBasket.Id,
            Name = shoppingBasket.Name,
            UniqueString = shoppingBasket.UniqueString,
            IsOwner = shoppingBasket.ShoppingBasketUsers.Any(user => user.UserId == userContext.UserId && user.IsOwner),
            IsClosed = shoppingBasket.IsClosed
        };
    }

    public async Task<List<GetShoppingBasketResponse>> GetAllOpenShoppingBasketsAsync()
    {
        logger.LogInformation($"Getting all open shopping baskets for user with ID: {userContext.UserId}");

        var shoppingBaskets = await shoppingBasketRepository.GetAllShoppingBasketsByUserIdAsync(userContext.UserId, false);

        if (shoppingBaskets == null || !shoppingBaskets.Any())
        {
            logger.LogWarning($"No shopping baskets found for user with ID: {userContext.UserId}");
            return new List<GetShoppingBasketResponse>();
        }

        return shoppingBaskets.Select(basket => new GetShoppingBasketResponse
        {
            Id = basket.Id,
            Name = basket.Name,
            UniqueString = basket.UniqueString,
            IsOwner = basket.ShoppingBasketUsers.Any(user => user.UserId == userContext.UserId && user.IsOwner),
            IsClosed = basket.IsClosed
        }).ToList();
    }
    
    public async Task<List<GetShoppingBasketResponse>> GetAllClosedShoppingBasketsAsync()
    {
        logger.LogInformation($"Getting all closed shopping baskets for user with ID: {userContext.UserId}");

        var shoppingBaskets = await shoppingBasketRepository.GetAllShoppingBasketsByUserIdAsync(userContext.UserId, true);

        if (shoppingBaskets == null || !shoppingBaskets.Any())
        {
            logger.LogWarning($"No shopping baskets found for user with ID: {userContext.UserId}");
            return new List<GetShoppingBasketResponse>();
        }

        return shoppingBaskets.Select(basket => new GetShoppingBasketResponse
        {
            Id = basket.Id,
            Name = basket.Name,
            UniqueString = basket.UniqueString,
            IsOwner = basket.ShoppingBasketUsers.Any(user => user.UserId == userContext.UserId && user.IsOwner),
            IsClosed = basket.IsClosed
        }).ToList();
    }

    public async Task DeleteShoppingBasketAsync(Guid id)
    {
        logger.LogInformation($"Deleting shopping basket with ID: {id}");

        var isUserBasketOwner = await shoppingBasketUserRepository.IsUserBasketOwnerAsync(id, userContext.UserId);
        if (!isUserBasketOwner)
        {
            logger.LogError($"User with ID {userContext.UserId} is not authorized to delete shopping basket with ID {id}.");
            throw new UnauthorizedAccessException($"User with ID {userContext.UserId} is not authorized to delete this shopping basket.");
        }

        var shoppingBasket = await shoppingBasketRepository.GetShoppingBasketByIdAsync(id);

        if (shoppingBasket == null)
        {
            logger.LogError($"Shopping basket with ID {id} not found.");
            throw new ShoppingBasketNotFoundException($"Shopping basket with ID {id} not found.");
        }

        await shoppingBasketRepository.DeleteBasketAsync(shoppingBasket);
        logger.LogInformation($"Shopping basket with ID {id} deleted successfully.");
    }

    public async Task UpdateShoppingBasketAsync(Guid id, string name)
    {
        if (string.IsNullOrWhiteSpace(name))
        {
            logger.LogError("Shopping basket name cannot be null or empty.");
            throw new ArgumentException("Shopping basket name cannot be null or empty.", nameof(name));
        }

        logger.LogInformation($"Updating shopping basket with ID: {id}");

        var isUserBasketOwner = await shoppingBasketUserRepository.IsUserBasketOwnerAsync(id, userContext.UserId);
        if (!isUserBasketOwner)
        {
            logger.LogError($"User with ID {userContext.UserId} is not authorized to update shopping basket with ID {id}.");
            throw new UnauthorizedAccessException($"User with ID {userContext.UserId} is not authorized to update this shopping basket.");
        }

        var shoppingBasket = await shoppingBasketRepository.GetShoppingBasketByIdAsync(id);

        if (shoppingBasket == null)
        {
            logger.LogError($"Shopping basket with ID {id} not found.");
            throw new ShoppingBasketNotFoundException($"Shopping basket with ID {id} not found.");
        }

        shoppingBasket.Name = name;
        await shoppingBasketRepository.UpdateShoppingBasketAsync(shoppingBasket);

        logger.LogInformation($"Shopping basket with ID {id} updated successfully.");
    }

    public async Task AddUserToShoppingBasketAsync(Guid basketId, Guid userId)
    {
        logger.LogInformation($"Adding user with ID {userId} to shopping basket with ID {basketId}");

        var isBasketExists = await shoppingBasketRepository.DoesBasketWithIdExist(basketId);

        if (!isBasketExists)
        {
            logger.LogError($"Shopping basket with ID {basketId} does not exist.");
            throw new ShoppingBasketNotFoundException($"Shopping basket with ID {basketId} does not exist.");
        }

        var isUserInBasket = await shoppingBasketUserRepository.IsUserInShoppingBasketAsync(basketId, userId);
        if (isUserInBasket)
        {
            logger.LogWarning($"User with ID {userId} is already in shopping basket with ID {basketId}");
            return;
        }

        var shoppingBasketUser = new ShoppingBasketUsers
        {
            UserId = userId,
            ShoppingBasketId = basketId,
            IsOwner = false
        };

        await shoppingBasketUserRepository.CreateAsync(shoppingBasketUser);
        logger.LogInformation($"User with ID {userId} added to shopping basket with ID {basketId}");
    }

    public async Task<GetShoppingBasketResponse> GetShoppingBasketUsingUniqueStringAsync(string uniqueString)
    {
        if (string.IsNullOrWhiteSpace(uniqueString))
        {
            logger.LogError("Unique string cannot be null or empty.");
            throw new ArgumentException("Unique string cannot be null or empty.", nameof(uniqueString));
        }

        logger.LogInformation($"Getting shopping basket using unique string: {uniqueString}");

        var shoppingBasket = await shoppingBasketRepository.GetShoppingBasketByUniqueStringAsync(uniqueString);

        if (shoppingBasket == null)
        {
            logger.LogError($"Shopping basket with unique string {uniqueString} not found.");
            throw new ShoppingBasketNotFoundException($"Shopping basket with unique string {uniqueString} not found.");
        }

        return new GetShoppingBasketResponse
        {
            Id = shoppingBasket.Id,
            Name = shoppingBasket.Name,
            UniqueString = shoppingBasket.UniqueString,
            IsOwner = false
        };
    }
    
    public async Task CloseShoppingBasketAsync(Guid id)
    {
        logger.LogInformation($"Closing shopping basket with ID: {id}");

        var isUserBasketOwner = await shoppingBasketUserRepository.IsUserBasketOwnerAsync(id, userContext.UserId);
        if (!isUserBasketOwner)
        {
            logger.LogError($"User with ID {userContext.UserId} is not authorized to close shopping basket with ID {id}.");
            throw new UnauthorizedAccessException($"User with ID {userContext.UserId} is not authorized to close this shopping basket.");
        }

        var shoppingBasket = await shoppingBasketRepository.GetShoppingBasketByIdAsync(id);

        if (shoppingBasket == null)
        {
            logger.LogError($"Shopping basket with ID {id} not found.");
            throw new ShoppingBasketNotFoundException($"Shopping basket with ID {id} not found.");
        }

        shoppingBasket.IsClosed = true;
        await shoppingBasketRepository.UpdateShoppingBasketAsync(shoppingBasket);

        logger.LogInformation($"Shopping basket with ID {id} closed successfully.");
    }
}

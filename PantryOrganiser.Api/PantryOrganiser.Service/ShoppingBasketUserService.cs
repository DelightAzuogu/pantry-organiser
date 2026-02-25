using Microsoft.Extensions.Logging;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Service;

public class ShoppingBasketUserService(ILogger<ShoppingBasketUsers> logger, IShoppingBasketUserRepository shoppingBasketUserRepository) : IShoppingBasketUserService
{
    public async Task<ShoppingBasketUsers> GetShoppingBasketUserByIdAsync(Guid id)
    {
        logger.LogInformation($"Get shopping basket user by id: {id}");
        var user = await shoppingBasketUserRepository.GetShoppingBasketUserByIdAsync(id);

        if (user == null)
        {
            logger.LogError($"Shopping basket user with ID {id} not found.");
            throw new ShoppingBasketUserNotFoundException($"Shopping basket user with ID {id} not found.");
        }

        return user;
    }
}

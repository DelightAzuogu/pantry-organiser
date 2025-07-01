using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Constants;
using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Api.Controllers;

[ApiController]
[Route("api/shopping-baskets")]
[Authorize(AuthorisationPolicies.Users)]
public class ShoppingBasketController(
    ILogger<ShoppingBasketController> logger,
    IUserContext userContext,
    IShoppingBasketItemService shoppingBasketItemService,
    IShoppingBasketService shoppingBasketService
) : ControllerBase
{
    [HttpPost("create")]
    public async Task<IActionResult> CreateShoppingBasket([FromBody] string name)
    {
        try
        {
            logger.LogInformation("Creating shopping basket with name {Name} for user {UserId}", name, userContext.UserId);

            await shoppingBasketService.CreateShoppingBasketAsync(name);
            return Created();
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while creating shopping basket");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpGet("{id:guid}")]
    public async Task<IActionResult> GetShoppingBasket(Guid id)
    {
        try
        {
            logger.LogInformation("Getting shopping basket {BasketId} for user {UserId}", id, userContext.UserId);

            var basket = await shoppingBasketService.GetShoppingBasketAsync(id);
            return Ok(basket);
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (ShoppingBasketNotFoundException e)
        {
            logger.LogError(e, "Shopping basket not found: {BasketId}", id);
            return NotFound("Shopping basket not found");
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to access basket {BasketId}", userContext.UserId, id);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while getting shopping basket");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpGet("open")]
    public async Task<IActionResult> GetAllOpenShoppingBaskets()
    {
        try
        {
            logger.LogInformation("Getting all open shopping baskets for user {UserId}", userContext.UserId);

            var baskets = await shoppingBasketService.GetAllOpenShoppingBasketsAsync();
            return Ok(baskets);
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while getting open shopping baskets");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpGet("closed")]
    public async Task<IActionResult> GetAllClosedShoppingBaskets()
    {
        try
        {
            logger.LogInformation("Getting all closed shopping baskets for user {UserId}", userContext.UserId);

            var baskets = await shoppingBasketService.GetAllClosedShoppingBasketsAsync();
            return Ok(baskets);
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while getting closed shopping baskets");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("delete/{id:guid}")]
    public async Task<IActionResult> DeleteShoppingBasket(Guid id)
    {
        try
        {
            logger.LogInformation("Deleting shopping basket {BasketId} for user {UserId}", id, userContext.UserId);

            await shoppingBasketService.DeleteShoppingBasketAsync(id);
            return Ok("Shopping basket deleted successfully.");
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (ShoppingBasketNotFoundException e)
        {
            logger.LogError(e, "Shopping basket not found: {BasketId}", id);
            return NotFound("Shopping basket not found");
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to delete basket {BasketId}", userContext.UserId, id);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while deleting shopping basket");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("update/{id:guid}")]
    public async Task<IActionResult> UpdateShoppingBasket([FromRoute]Guid id, [FromBody] string name)
    {
        try
        {
            logger.LogInformation("Updating shopping basket {BasketId} with name {Name} for user {UserId}", id, name, userContext.UserId);

            await shoppingBasketService.UpdateShoppingBasketAsync(id, name);
            return Ok("Shopping basket updated successfully.");
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (ShoppingBasketNotFoundException e)
        {
            logger.LogError(e, "Shopping basket not found: {BasketId}", id);
            return NotFound("Shopping basket not found");
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to update basket {BasketId}", userContext.UserId, id);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while updating shopping basket");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("{basketId:guid}/add-user")]
    public async Task<IActionResult> AddUserToShoppingBasket([FromRoute] Guid basketId, [FromBody] Guid userId)
    {
        try
        {
            logger.LogInformation("Adding user {UserId} to shopping basket {BasketId} by user {CurrentUserId}",
                userId, basketId, userContext.UserId);

            await shoppingBasketService.AddUserToShoppingBasketAsync(basketId, userId);
            return Ok("User added to shopping basket successfully.");
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (ShoppingBasketNotFoundException e)
        {
            logger.LogError(e, "Shopping basket not found: {BasketId}", basketId);
            return NotFound("Shopping basket not found");
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to add users to basket {BasketId}", userContext.UserId, basketId);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while adding user to shopping basket");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpGet("unique/{uniqueString}")]
    public async Task<IActionResult> GetShoppingBasketByUniqueString(string uniqueString)
    {
        try
        {
            logger.LogInformation("Getting shopping basket by unique string {UniqueString} for user {UserId}", uniqueString, userContext.UserId);

            var basket = await shoppingBasketService.GetShoppingBasketUsingUniqueStringAsync(uniqueString);
            return Ok(basket);
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (ShoppingBasketNotFoundException e)
        {
            logger.LogError(e, "Shopping basket not found with unique string: {UniqueString}", uniqueString);
            return NotFound("Shopping basket not found");
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to access basket with unique string {UniqueString}", userContext.UserId, uniqueString);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while getting shopping basket by unique string");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("close/{id:guid}")]
    public async Task<IActionResult> CloseShoppingBasket(Guid id)
    {
        try
        {
            logger.LogInformation("Closing shopping basket {BasketId} for user {UserId}", id, userContext.UserId);

            await shoppingBasketService.CloseShoppingBasketAsync(id);
            return Ok("Shopping basket closed successfully.");
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (ShoppingBasketNotFoundException e)
        {
            logger.LogError(e, "Shopping basket not found: {BasketId}", id);
            return NotFound("Shopping basket not found");
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to close basket {BasketId}", userContext.UserId, id);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while closing shopping basket");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }
    
    [HttpPost("items/add")]
    public async Task<IActionResult> AddItemToBasket([FromBody] AddShoppingBasketItem request)
    {
        try
        {
            logger.LogInformation("Adding item to shopping basket for user {UserId}", userContext.UserId);

            await shoppingBasketItemService.AddItemToBasketAsync(request);
            return Ok("Item added to basket successfully.");
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (ShoppingBasketNotFoundException e)
        {
            logger.LogError(e, "Shopping basket not found: {BasketId}", request.ShoppingBasketId);
            return NotFound("Shopping basket not found");
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to add items to basket", userContext.UserId);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while adding item to basket");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpGet("items/{shoppingBasketId:guid}")]
    public async Task<IActionResult> GetItemsByBasketId(Guid shoppingBasketId)
    {
        try
        {
            logger.LogInformation("Getting items for shopping basket {BasketId} for user {UserId}", shoppingBasketId, userContext.UserId);

            var items = await shoppingBasketItemService.GetItemsByBasketIdAsync(shoppingBasketId);
            return Ok(items);
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (ShoppingBasketNotFoundException e)
        {
            logger.LogError(e, "Shopping basket not found: {BasketId}", shoppingBasketId);
            return NotFound("Shopping basket not found");
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to access basket {BasketId}", userContext.UserId, shoppingBasketId);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while getting basket items");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("items/checkout")]
    public async Task<IActionResult> CheckoutShoppingBasketItems([FromBody] CheckoutShoppingBasketItemsRequest request)
    {
        try
        {
            logger.LogInformation("Checking out shopping basket items for user {UserId}", userContext.UserId);

            await shoppingBasketItemService.CheckoutShoppingBasketItemsAsync(request);
            return Ok("Items checked out successfully.");
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (ShoppingBasketItemNotFoundException e)
        {
            logger.LogError(e, "Shopping basket items not found for checkout");
            return NotFound("Shopping basket items not found");
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to checkout items", userContext.UserId);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while checking out items");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("items/delete/{shoppingBasketItemId:guid}")]
    public async Task<IActionResult> DeleteShoppingBasketItem(Guid shoppingBasketItemId)
    {
        try
        {
            logger.LogInformation("Deleting shopping basket item {ItemId} for user {UserId}", shoppingBasketItemId, userContext.UserId);

            await shoppingBasketItemService.DeleteShoppingBasketItemAsync(shoppingBasketItemId);
            return Ok("Shopping basket item deleted successfully.");
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (ShoppingBasketItemNotFoundException e)
        {
            logger.LogError(e, "Shopping basket item not found: {ItemId}", shoppingBasketItemId);
            return NotFound("Shopping basket item not found");
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to delete item {ItemId}", userContext.UserId, shoppingBasketItemId);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while deleting shopping basket item");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("items/update")]
    public async Task<IActionResult> UpdateShoppingBasketItem([FromBody] UpdateShoppingBasketItemRequest request)
    {
        try
        {
            logger.LogInformation("Updating shopping basket item for user {UserId}", userContext.UserId);

            await shoppingBasketItemService.UpdateShoppingBasketItemAsync(request);
            return Ok("Shopping basket item updated successfully.");
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (ShoppingBasketItemNotFoundException e)
        {
            logger.LogError(e, "Shopping basket item not found for update");
            return NotFound("Shopping basket item not found");
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to update item", userContext.UserId);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while updating shopping basket item");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }
}

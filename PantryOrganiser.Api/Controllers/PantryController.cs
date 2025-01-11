using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Constants;
using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Api.Controllers;

[ApiController]
[Route("api/pantry")]
[Authorize(AuthorisationPolicies.Users)]
public class PantryController(ILogger<PantryController> logger, IUserContext userContext, IPantryService pantryService, IPantryItemService pantryItemService) : ControllerBase
{
    [HttpPost("create")]
    public async Task<IActionResult> CreatePantry([FromBody] string name)
    {
        try
        {
            logger.LogInformation("Creating pantry with name: {Name} by user {user}", name, userContext.UserId);

            var result = await pantryService.CreatePantryAsync(name, userContext.UserId);
            return Ok(result);
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while creating pantry");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpGet("user")]
    public async Task<IActionResult> GetUserPantries()
    {
        try
        {
            logger.LogInformation("Getting pantries for user {user}", userContext.UserId);

            var result = await pantryService.GetPantriesByUserIdAsync(userContext.UserId);
            return Ok(result);
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while getting user pantries");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("{pantryId:guid}/update")]
    public async Task<IActionResult> UpdatePantry([FromRoute] Guid pantryId, [FromBody] string name)
    {
        try
        {
            logger.LogInformation("Updating pantry with id: {PantryId} by user {user}", pantryId, userContext.UserId);

            await pantryService.UpdatePantryAsync(new UpdatePantryRequest
            {
                Name = name,
                PantryId = pantryId
            }, userContext.UserId);

            return Ok();
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (PantryNotFoundException e)
        {
            logger.LogError(e, "Pantry not found: {PantryId}", pantryId);
            return NotFound(ResponseMessages.PantryNotFound);
        }
        catch (PantryOwnershipException e)
        {
            logger.LogError(e, "Pantry {PantryId} does not belong to user {UserId}", pantryId, userContext.UserId);
            return StatusCode(StatusCodes.Status403Forbidden, ResponseMessages.PantryDoesNotBelongToUser);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while updating pantry");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("{pantryId:guid}/delete")]
    public async Task<IActionResult> DeletePantry(Guid pantryId)
    {
        try
        {
            logger.LogInformation("Deleting pantry with id: {PantryId} by user {user}", pantryId, userContext.UserId);

            await pantryService.DeletePantryByIdAsync(pantryId, userContext.UserId);
            return Ok();
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (PantryNotFoundException e)
        {
            logger.LogError(e, "Pantry not found: {PantryId}", pantryId);
            return NotFound(ResponseMessages.PantryNotFound);
        }
        catch (PantryOwnershipException e)
        {
            logger.LogError(e, "Pantry {PantryId} does not belong to user {UserId}", pantryId, userContext.UserId);
            return StatusCode(StatusCodes.Status403Forbidden, ResponseMessages.PantryDoesNotBelongToUser);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while deleting pantry");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("item/{pantryId:guid}")]
    public async Task<IActionResult> AddPantryItem([FromRoute] Guid pantryId, CreatePantryItemRequest request)
    {
        try
        {
            logger.LogInformation("Adding an item to pantry {pantryId} by user {user}", pantryId, userContext.UserId);
            var result = await pantryItemService.AddPantryItemAsync(request, pantryId, userContext.UserId);

            return Ok(result);
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (PantryNotFoundException e)
        {
            logger.LogError(e, "Pantry not found: {PantryId}", pantryId);
            return NotFound(ResponseMessages.PantryNotFound);
        }
        catch (PantryOwnershipException e)
        {
            logger.LogError(e, "Pantry {PantryId} does not belong to user {UserId}", pantryId, userContext.UserId);
            return StatusCode(StatusCodes.Status403Forbidden, ResponseMessages.PantryDoesNotBelongToUser);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while deleting pantry");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpGet("item/{pantryItemId:guid}")]
    public async Task<IActionResult> GetPantryItemAsync([FromRoute] Guid pantryItemId)
    {
        try
        {
            logger.LogInformation("Getting pantry item {pantryItem} by user {user}", pantryItemId, userContext.UserId);

            var result = await pantryItemService.GetPantryItemAsync(pantryItemId, userContext.UserId);
            return Ok(result);
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (PantryItemNotFoundException e)
        {
            logger.LogError(e, "Pantry item not found: {PantryItemId}", pantryItemId);
            return NotFound(ResponseMessages.PantryItemNotFound);
        }
        catch (PantryItemOwnershipException e)
        {
            logger.LogError(e, "Pantry item {PantryItemId} does not belong to user {UserId}", pantryItemId, userContext.UserId);
            return StatusCode(StatusCodes.Status403Forbidden, ResponseMessages.PantryItemDoesNotBelongToUser);
        }
        catch (PantryNotFoundException e)
        {
            logger.LogError(e, "Pantry not found");
            return NotFound(ResponseMessages.PantryNotFound);
        }
        catch (PantryOwnershipException e)
        {
            logger.LogError(e, "Pantry item does not belong to user {UserId}", userContext.UserId);
            return StatusCode(StatusCodes.Status403Forbidden, ResponseMessages.PantryDoesNotBelongToUser);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while deleting pantry");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("items/{pantryId:guid}")]
    public async Task<IActionResult> GetItemsInPantry([FromRoute] Guid pantryId)
    {
        try
        {
            logger.LogInformation("Getting items in pantry {pantryId} by user {user}", pantryId, userContext.UserId);

            var result = await pantryItemService.GetItemsInAPantryAsync(pantryId, userContext.UserId);
            return Ok(result);
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (PantryNotFoundException e)
        {
            logger.LogError(e, "Pantry not found: {PantryId}", pantryId);
            return NotFound(ResponseMessages.PantryNotFound);
        }
        catch (PantryOwnershipException e)
        {
            logger.LogError(e, "Pantry {PantryId} does not belong to user {UserId}", pantryId, userContext.UserId);
            return StatusCode(StatusCodes.Status403Forbidden, ResponseMessages.PantryDoesNotBelongToUser);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while deleting pantry");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("item/{pantryItemId:guid}/update")]
    public async Task<IActionResult> UpdatePantryItem([FromRoute] Guid pantryItemId, [FromBody] UpdatePantryItemRequest request)
    {
        try
        {
            logger.LogInformation("Updating pantry item {pantryItemId} by user {user}", pantryItemId, userContext.UserId);

            await pantryItemService.UpdatePantryItemAsync(pantryItemId, request, userContext.UserId);
            return Ok();
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (PantryItemNotFoundException e)
        {
            logger.LogError(e, "Pantry item not found: {PantryItemId}", pantryItemId);
            return NotFound(ResponseMessages.PantryItemNotFound);
        }
        catch (PantryItemOwnershipException e)
        {
            logger.LogError(e, "Pantry item {PantryItemId} does not belong to user {UserId}", pantryItemId, userContext.UserId);
            return StatusCode(StatusCodes.Status403Forbidden, ResponseMessages.PantryItemDoesNotBelongToUser);
        }
        catch (PantryNotFoundException e)
        {
            logger.LogError(e, "Pantry not found");
            return NotFound(ResponseMessages.PantryNotFound);
        }
        catch (PantryOwnershipException e)
        {
            logger.LogError(e, "Pantry item does not belong to user {UserId}", userContext.UserId);
            return StatusCode(StatusCodes.Status403Forbidden, ResponseMessages.PantryDoesNotBelongToUser);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while deleting pantry");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("item/{pantryItemId:guid}/delete")]
    public async Task<IActionResult> DeletePantryItemAsync([FromRoute] Guid pantryItemId)
    {
        try
        {
            logger.LogInformation("Deleting pantry item {pantryItemId} by user {user}", pantryItemId, userContext.UserId);

            await pantryItemService.DeletePantryItemAsync(pantryItemId, userContext.UserId);
            return Ok();
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (PantryItemNotFoundException e)
        {
            logger.LogError(e, "Pantry item not found: {PantryItemId}", pantryItemId);
            return NotFound(ResponseMessages.PantryItemNotFound);
        }
        catch (PantryItemOwnershipException e)
        {
            logger.LogError(e, "Pantry item {PantryItemId} does not belong to user {UserId}", pantryItemId, userContext.UserId);
            return StatusCode(StatusCodes.Status403Forbidden, ResponseMessages.PantryItemDoesNotBelongToUser);
        }
        catch (PantryNotFoundException e)
        {
            logger.LogError(e, "Pantry not found");
            return NotFound(ResponseMessages.PantryNotFound);
        }
        catch (PantryOwnershipException e)
        {
            logger.LogError(e, "Pantry item does not belong to user {UserId}", userContext.UserId);
            return StatusCode(StatusCodes.Status403Forbidden, ResponseMessages.PantryDoesNotBelongToUser);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while deleting pantry");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }
}

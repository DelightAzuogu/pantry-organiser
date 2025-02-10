using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Constants;
using PantryOrganiser.Shared.Dto;
using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Api.Controllers;

[ApiController]
[Route("api/pantry")]
[Authorize(AuthorisationPolicies.Users)]
public class PantryController(
    ILogger<PantryController> logger,
    IUserContext userContext,
    IPantryService pantryService,
    IPantryItemService pantryItemService,
    IPantryUserService pantryUserService
) : ControllerBase
{
    [HttpPost("create")]
    public async Task<IActionResult> CreatePantry([FromBody] CreatePantryRequest request)
    {
        try
        {
            logger.LogInformation("Creating pantry with name: {Name} by user {user}", request.Name, userContext.UserId);

            await pantryService.CreatePantryAsync(request.Name, userContext.UserId);

            return StatusCode(StatusCodes.Status201Created);
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

    [HttpGet("")]
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
    public async Task<IActionResult> UpdatePantry([FromRoute] Guid pantryId, [FromBody] CreatePantryRequest request)
    {
        try
        {
            logger.LogInformation("Updating pantry with id: {PantryId} by user {user}", pantryId, userContext.UserId);

            await pantryService.UpdatePantryAsync(new UpdatePantryRequest
            {
                Name = request.Name,
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
        catch (PantryRoleNotFoundException e)
        {
            logger.LogError(e, "Pantry role not found");
            return NotFound(ResponseMessages.PantryRoleNotFound);
        }
        catch (PantryUserNotFoundException e)
        {
            logger.LogError(e, "Pantry user not found");
            return NotFound(ResponseMessages.PantryUserNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while updating pantry");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("{pantryId:guid}/delete")]
    public async Task<IActionResult> DeletePantry([FromRoute] Guid pantryId)
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
        catch (PantryRoleNotFoundException e)
        {
            logger.LogError(e, "Pantry role not found");
            return NotFound(ResponseMessages.PantryRoleNotFound);
        }
        catch (PantryUserNotFoundException e)
        {
            logger.LogError(e, "Pantry user not found");
            return NotFound(ResponseMessages.PantryUserNotFound);
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
        catch (PantryRoleNotFoundException e)
        {
            logger.LogError(e, "Pantry role not found");
            return NotFound(ResponseMessages.PantryRoleNotFound);
        }
        catch (PantryUserNotFoundException e)
        {
            logger.LogError(e, "Pantry user not found");
            return NotFound(ResponseMessages.PantryUserNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while adding pantry item");
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
        catch (PantryNotFoundException e)
        {
            logger.LogError(e, "Pantry not found");
            return NotFound(ResponseMessages.PantryNotFound);
        }
        catch (PantryUserNotFoundException e)
        {
            logger.LogError(e, "Pantry user not found");
            return NotFound(ResponseMessages.PantryUserNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while getting pantry items");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpGet("{pantryId:guid}/items")]
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
        catch (PantryUserNotFoundException e)
        {
            logger.LogError(e, "Pantry user not found");
            return NotFound(ResponseMessages.PantryUserNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while adding to pantry");
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
        catch (PantryRoleNotFoundException e)
        {
            logger.LogError(e, "Pantry role not found");
            return NotFound(ResponseMessages.PantryRoleNotFound);
        }
        catch (PantryUserNotFoundException e)
        {
            logger.LogError(e, "Pantry user not found");
            return NotFound(ResponseMessages.PantryUserNotFound);
        }
        catch (PantryNotFoundException e)
        {
            logger.LogError(e, "Pantry not found");
            return NotFound(ResponseMessages.PantryNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while updating pantry");
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
        catch (PantryRoleNotFoundException e)
        {
            logger.LogError(e, "Pantry role not found");
            return NotFound(ResponseMessages.PantryRoleNotFound);
        }
        catch (PantryUserNotFoundException e)
        {
            logger.LogError(e, "Pantry user not found");
            return NotFound(ResponseMessages.PantryUserNotFound);
        }
        catch (PantryNotFoundException e)
        {
            logger.LogError(e, "Pantry not found");
            return NotFound(ResponseMessages.PantryNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while deleting pantry");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("{pantryId:guid}/add-user")]
    public async Task<IActionResult> AddUserToPantry([FromRoute] Guid pantryId, [FromBody] AddUserToPantryRequest request)
    {
        try
        {
            logger.LogInformation("Adding user {UserId} to pantry {PantryId} by user {user}", request.Email, pantryId, userContext.UserId);

            await pantryUserService.AddUserToPantryAsync(request, pantryId, userContext.UserId);
            return Ok();
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (PantryUserExistsException e)
        {
            logger.LogError(e, "User {UserId} already exists in pantry {PantryId}", request.Email, pantryId);
            return StatusCode(StatusCodes.Status409Conflict, ResponseMessages.UserAlreadyExistsInPantry);
        }
        catch (PantryUserNotFoundException e)
        {
            logger.LogError(e, "User {UserId} not found in pantry {PantryId}", request.Email, pantryId);
            return NotFound(ResponseMessages.UserNotFoundInPantry);
        }
        catch (PantryNotFoundException e)
        {
            logger.LogError(e, "Pantry not found: {PantryId}", pantryId);
            return NotFound(ResponseMessages.PantryNotFound);
        }
        catch (PantryRoleNotFoundException e)
        {
            logger.LogError(e, "Pantry role not found");
            return NotFound(ResponseMessages.PantryRoleNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while adding user to pantry");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("remove-user/{pantryUserId:guid}")]
    public async Task<IActionResult> RemoveUserToPantry([FromRoute] Guid pantryUserId)
    {
        try
        {
            logger.LogInformation("Removing user {UserId} from pantry by user {user}", pantryUserId, userContext.UserId);

            await pantryUserService.RemoveUserFromPantryAsync(pantryUserId, userContext.UserId);
            return Ok();
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (PantryUserNotFoundException e)
        {
            logger.LogError(e, $"Pantry user not found {pantryUserId}");
            return NotFound(ResponseMessages.UserNotFoundInPantry);
        }
        catch (PantryRoleNotFoundException e)
        {
            logger.LogError(e, "Pantry role not found");
            return NotFound(ResponseMessages.PantryRoleNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while removing user to pantry");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpGet("{pantry:guid}/users")]
    public async Task<IActionResult> GetPantryUsers([FromRoute] Guid pantryId)
    {
        try
        {
            logger.LogInformation("Getting users in pantry {pantryId} by user {user}", pantryId, userContext.UserId);

            var result = await pantryUserService.GetPantryUsersByPantryIdAsync(pantryId, userContext.UserId);
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
        catch (PantryRoleNotFoundException e)
        {
            logger.LogError(e, "Pantry role not found");
            return NotFound(ResponseMessages.PantryRoleNotFound);
        }
        catch (PantryUserNotFoundException e)
        {
            logger.LogError(e, "Pantry user not found");
            return NotFound(ResponseMessages.PantryUserNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while getting pantry users");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("{pantryUserId:guid}/update-user-role")]
    public async Task<IActionResult> UpdateUserRoleInPantry([FromRoute] Guid pantryUserId, [FromBody] AddRolesToUserInPantryRequest request)
    {
        try
        {
            logger.LogInformation("Updating user role in pantry {pantryUserId} by user {user}", pantryUserId, userContext.UserId);

            await pantryUserService.AddRolesToUserInPantryAsync(request, pantryUserId, userContext.UserId);
            return Ok();
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (PantryUserNotFoundException e)
        {
            logger.LogError(e, $"Pantry user not found {pantryUserId}");
            return NotFound(ResponseMessages.UserNotFoundInPantry);
        }
        catch (PantryRoleNotFoundException e)
        {
            logger.LogError(e, "Pantry role not found");
            return NotFound(ResponseMessages.PantryRoleNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while updating user role in pantry");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }
}

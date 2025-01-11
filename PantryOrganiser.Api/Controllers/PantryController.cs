using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Constants;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Api.Controllers;

[ApiController]
[Route("api/pantry")]
[Authorize(AuthorisationPolicies.Users)]
public class PantryController(ILogger<PantryController> logger, IUserContext userContext, IPantryService pantryService) : ControllerBase
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
}

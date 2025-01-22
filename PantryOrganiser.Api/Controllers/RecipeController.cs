using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Constants;
using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Api.Controllers;

[ApiController]
[Route("api/recipes")]
[Authorize(AuthorisationPolicies.Users)]
public class RecipeController(
    ILogger<RecipeController> logger,
    IUserContext userContext,
    IRecipeService recipeService
) : ControllerBase
{
    [HttpPost("create")]
    public async Task<IActionResult> CreateRecipe([FromBody] AddRecipeRequest request)
    {
        try
        {
            logger.LogInformation("Creating recipe with name: {Name} by user {UserId}", request.Name, userContext.UserId);

            await recipeService.AddRecipeAsync(request, userContext.UserId);
            return Ok("Recipe created successfully.");
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while creating recipe");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpGet("all")]
    public async Task<IActionResult> GetAllRecipes()
    {
        try
        {
            logger.LogInformation("Retrieving recipes for user {UserId}", userContext.UserId);

            var recipes = await recipeService.GetRecipesByUserIdAsync(userContext.UserId);
            return Ok(recipes);
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while retrieving recipes");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpGet("{recipeId:guid}")]
    public async Task<IActionResult> GetRecipeDetails(Guid recipeId)
    {
        try
        {
            logger.LogInformation("Retrieving details for recipe {RecipeId} by user {UserId}", recipeId, userContext.UserId);

            var recipeDetails = await recipeService.GetRecipeDetailsByIdAsync(recipeId, userContext.UserId);
            return Ok(recipeDetails);
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (RecipeNotFoundException e)
        {
            logger.LogError(e, "Recipe not found: {RecipeId}", recipeId);
            return NotFound(ResponseMessages.RecipeNotFound);
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to view recipe {RecipeId}", userContext.UserId, recipeId);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while retrieving recipe details");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("{recipeId:guid}/update")]
    public async Task<IActionResult> UpdateRecipe(Guid recipeId, [FromBody] AddRecipeRequest request)
    {
        try
        {
            logger.LogInformation("Updating recipe {RecipeId} by user {UserId}", recipeId, userContext.UserId);

            await recipeService.UpdateRecipeAsync(recipeId, request, userContext.UserId);
            return Ok("Recipe updated successfully.");
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (RecipeNotFoundException e)
        {
            logger.LogError(e, "Recipe not found: {RecipeId}", recipeId);
            return NotFound(ResponseMessages.RecipeNotFound);
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to update recipe {RecipeId}", userContext.UserId, recipeId);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while updating recipe");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }

    [HttpPost("{recipeId:guid}/delete")]
    public async Task<IActionResult> DeleteRecipe(Guid recipeId)
    {
        try
        {
            logger.LogInformation("Deleting recipe {RecipeId} by user {UserId}", recipeId, userContext.UserId);

            await recipeService.DeleteRecipeAsync(recipeId, userContext.UserId);
            return Ok("Recipe deleted successfully.");
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e, "User not found: {UserId}", userContext.UserId);
            return NotFound(ResponseMessages.UserNotFound);
        }
        catch (RecipeNotFoundException e)
        {
            logger.LogError(e, "Recipe not found: {RecipeId}", recipeId);
            return NotFound(ResponseMessages.RecipeNotFound);
        }
        catch (UnauthorizedAccessException e)
        {
            logger.LogError(e, "User {UserId} not authorized to delete recipe {RecipeId}", userContext.UserId, recipeId);
            return Forbid(ResponseMessages.UnauthorizedAccess);
        }
        catch (Exception e)
        {
            logger.LogError(e, "Error occurred while deleting recipe");
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }
}

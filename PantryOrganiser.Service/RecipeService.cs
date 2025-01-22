using Microsoft.Extensions.Logging;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Service;

public class RecipeService(
    ILogger<RecipeService> logger,
    IRecipeRepository recipeRepository,
    IRecipeUserRepository recipeUserRepository,
    IRecipeIngredientRepository recipeIngredientRepository,
    IUserService userService
) : IRecipeService
{
    public async Task AddRecipeAsync(AddRecipeRequest request, Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);

        logger.LogInformation("Adding recipe with name {Name} for user with id {UserId}", request.Name, userId);
        var recipe = new Recipe
        {
            Name = request.Name,
            Description = request.Description,
            PrepTime = TimeSpan.Parse(request.PrepTimeString),
            CookTime = TimeSpan.Parse(request.CookTimeString),
            Instructions = request.Instructions,
            ServingSize = request.ServingSize
        };

        await recipeRepository.AddRecipeAsync(recipe);

        logger.LogInformation("Creating recipe user with recipe id {RecipeId} and user id {UserId}", recipe.Id, userId);
        var recipeUser = new RecipeUser
        {
            RecipeId = recipe.Id,
            UserId = userId,
            IsOwner = true
        };

        await recipeUserRepository.AddRecipeUserAsync(recipeUser);
    }

    public async Task<List<RecipeResponse>> GetRecipesByUserIdAsync(Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);

        logger.LogInformation("Getting recipes for user with id {UserId}", userId);
        var recipes = await recipeRepository.GetRecipesByUserIdAsync(userId);

        return recipes.Select(x => new RecipeResponse
        {
            Id = x.Id,
            Name = x.Name
        }).ToList();
    }

    public async Task<RecipeDetailsResponse> GetRecipeDetailsByIdAsync(Guid recipeId, Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);

        logger.LogInformation("Getting recipe details for user with id {UserId} and recipe with id {RecipeId}", userId, recipeId);
        var recipe = await recipeRepository.GetRecipeByIdAsync(recipeId);

        if (recipe == null)
        {
            logger.LogError("Recipe with id {RecipeId} not found", recipeId);
            throw new RecipeNotFoundException("Recipe not found");
        }

        var recipeUser = await recipeUserRepository.GetRecipeUserByRecipeIdAndUserIdAsync(recipeId, userId);

        if (recipeUser == null)
        {
            logger.LogError("User with id {UserId} is not authorized to view recipe with id {RecipeId}", userId, recipeId);
            throw new UnauthorizedAccessException("User is not authorized to view this recipe");
        }

        var recipeIngredients = await recipeIngredientRepository.GetRecipeIngredientsByRecipeIdAsync(recipeId);

        return new RecipeDetailsResponse
        {
            Id = recipe.Id,
            Name = recipe.Name,
            Description = recipe.Description,
            PrepTime = recipe.PrepTime,
            CookTime = recipe.CookTime,
            Instructions = recipe.Instructions,
            ServingSize = recipe.ServingSize,
            Ingredients = recipeIngredients.Select(x => new RecipeIngredientResponse
            {
                Id = x.Id,
                Name = x.PantryItem.Name,
                Quantity = x.PantryItem.Quantity,
                QuantityUnit = x.PantryItem.QuantityUnit,
                RecipeQuantity = x.Quantity
            }).ToList(),
            IsOwner = recipeUser.IsOwner
        };
    }

    public async Task UpdateRecipeAsync(Guid recipeId, AddRecipeRequest request, Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);

        logger.LogInformation("Updating recipe with id {RecipeId} for user with id {UserId}", recipeId, userId);
        if (!await recipeRepository.RecipeWithIdExistsAsync(recipeId))
        {
            logger.LogError("Recipe with id {RecipeId} not found", recipeId);
            throw new RecipeNotFoundException("Recipe not found");
        }

        var recipeUser = await recipeUserRepository.GetRecipeUserByRecipeIdAndUserIdAsync(recipeId, userId);

        if (recipeUser is not { IsOwner: true })
        {
            logger.LogError("User with id {UserId} is not authorized to update recipe with id {RecipeId}", userId, recipeId);
            throw new UnauthorizedAccessException("User is not authorized to update this recipe");
        }

        await recipeRepository.UpdateRecipeAsync(recipeId, request);
    }

    public async Task DeleteRecipeAsync(Guid recipeId, Guid userId)
    {
        await userService.ValidateUserExistenceByIdAsync(userId);

        logger.LogInformation("Deleting recipe with id {RecipeId} for user with id {UserId}", recipeId, userId);
        if (!await recipeRepository.RecipeWithIdExistsAsync(recipeId))
        {
            logger.LogError("Recipe with id {RecipeId} not found", recipeId);
            throw new RecipeNotFoundException("Recipe not found");
        }

        var recipeUser = await recipeUserRepository.GetRecipeUserByRecipeIdAndUserIdAsync(recipeId, userId);

        if (recipeUser is not { IsOwner: true })
        {
            logger.LogError("User with id {UserId} is not authorized to delete recipe with id {RecipeId}", userId, recipeId);
            throw new UnauthorizedAccessException("User is not authorized to delete this recipe");
        }

        await recipeRepository.DeleteRecipeAsync(recipeId);
    }
}

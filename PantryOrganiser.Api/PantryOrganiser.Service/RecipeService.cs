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

        logger.LogInformation("Creating recipe ingredients for recipe with id {RecipeId}", recipe.Id);
        foreach (var ingredient in request.Ingredients)
        {
            await recipeIngredientRepository.AddRecipeIngredientAsync(new RecipeIngredient
            {
                RecipeId = recipe.Id,
                Name = ingredient.Name,
                Quantity = ingredient.Quantity,
                QuantityUnit = ingredient.QuantityUnit
            });
        }

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

        return new RecipeDetailsResponse
        {
            Id = recipe.Id,
            Name = recipe.Name,
            Description = recipe.Description,
            PrepTime = recipe.PrepTime,
            CookTime = recipe.CookTime,
            Instructions = recipe.Instructions,
            ServingSize = recipe.ServingSize,
            IsOwner = recipeUser.IsOwner,
            Ingredients = recipe.RecipeIngredients.Select(x => new RecipeIngredientResponse
            {
                Id = x.Id,
                Name = x.Name,
                Quantity = x.Quantity,
                QuantityUnit = x.QuantityUnit
            }).ToList()
        };
    }

    public async Task<List<RecipeIngredientResponse>> GetRecipeIngredientsByRecipeIdAsync(Guid recipeId)
    {
        logger.LogInformation("validating id {RecipeId}", recipeId);
        if (!await recipeRepository.RecipeWithIdExistsAsync(recipeId))
        {
            logger.LogError("Recipe with id {RecipeId} not found", recipeId);
            throw new RecipeNotFoundException("Recipe not found");
        }

        logger.LogInformation("Getting recipe ingredients for recipe with id {RecipeId}", recipeId);
        var ingredients = await recipeIngredientRepository.GetRecipeIngredientsByRecipeIdAsync(recipeId);

        return ingredients.Select(x => new RecipeIngredientResponse
        {
            Name = x.Name,
            Quantity = x.Quantity,
            QuantityUnit = x.QuantityUnit
        }).ToList();
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

        logger.LogInformation("Updating recipe with id {RecipeId}", recipeId);
        await recipeRepository.UpdateRecipeAsync(recipeId, request);

        logger.LogInformation("Deleting existing recipe ingredients for recipe with id {RecipeId}", recipeId);
        await recipeIngredientRepository.DeleteRecipeIngredientsByRecipeIdAsync(recipeId);

        logger.LogInformation("Creating recipe ingredients for recipe with id {RecipeId}", recipeId);
        foreach (var ingredient in request.Ingredients)
        {
            await recipeIngredientRepository.AddRecipeIngredientAsync(new RecipeIngredient
            {
                RecipeId = recipeId,
                Name = ingredient.Name,
                Quantity = ingredient.Quantity,
                QuantityUnit = ingredient.QuantityUnit
            });
        }
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

        logger.LogInformation("Deleting recipe: {recipeId}", recipeId);
        await recipeRepository.DeleteRecipeAsync(recipeId);

        logger.LogInformation("Deleting recipe ingredients for recipe with id {RecipeId}", recipeId);
        await recipeIngredientRepository.DeleteRecipeIngredientsByRecipeIdAsync(recipeId);
    }

    public async Task UpdateRecipeIngredientAsync(UpdateRecipeIngredientRequest request, Guid userId)
    {
        logger.LogInformation("Getting ingredient with id {IngredientId} for recipe with id {RecipeId}", request.IngredientId, request.RecipeId);

        var ingredient = await recipeIngredientRepository.GetIngredientById(request.IngredientId);

        if (ingredient is null)
        {
            logger.LogError("Ingredient: {ingredientId} not found ", request.IngredientId);
            throw new IngredientNotFoundException("Ingredient not found ");
        }

        logger.LogInformation("Checking user recipe status for recipe with id {RecipeId} and user with id {UserId}", request.RecipeId, userId);

        var recipeUser = await recipeUserRepository.GetRecipeUserByRecipeIdAndUserIdAsync(ingredient.RecipeId, userId);

        if (recipeUser is not { IsOwner: true })
        {
            logger.LogError("User with id {UserId} is not authorized to update recipe with id {RecipeId}", userId, ingredient.RecipeId);
            throw new UnauthorizedAccessException("User is not authorized to update this recipe ingredient");
        }

        logger.LogInformation("Updating recipe ingredient with id {IngredientId} for recipe with id {RecipeId}", request.IngredientId, request.RecipeId);

        ingredient.Name = request.Name;
        ingredient.Quantity = request.Quantity;
        ingredient.QuantityUnit = request.QuantityUnit;

        await recipeIngredientRepository.UpdateIngredientAsync(ingredient);
    }

    public async Task DeleteRecipeIngredientAsync(Guid ingredientId, Guid userId)
    {
        logger.LogInformation("Getting ingredient with id {IngredientId}", ingredientId);

        var ingredient = await recipeIngredientRepository.GetIngredientById(ingredientId);

        if (ingredient is null)
        {
            logger.LogError("Ingredient: {ingredientId} not found ", ingredientId);
            throw new IngredientNotFoundException("Ingredient not found ");
        }

        logger.LogInformation("Checking user recipe status for recipe with id {RecipeId} and user with id {UserId}", ingredient.RecipeId, userId);

        var recipeUser = await recipeUserRepository.GetRecipeUserByRecipeIdAndUserIdAsync(ingredient.RecipeId, userId);

        if (recipeUser is not { IsOwner: true })
        {
            logger.LogError("User with id {UserId} is not authorized to delete recipe ingredient with id {IngredientId}", userId, ingredient.Id);
            throw new UnauthorizedAccessException("User is not authorized to delete this recipe ingredient");
        }

        logger.LogInformation("Deleting recipe ingredient with id {IngredientId} for recipe with id {RecipeId}", ingredient.Id, ingredient.RecipeId);

        await recipeIngredientRepository.DeleteIngredientAsync(ingredient);
    }

    public async Task AddUserToRecipeAsync(AddUserToRecipeRequest request, Guid userId)
    {
        var newUser = await userService.GetUserByEmailAsync(request.Email);

        if (!await recipeRepository.RecipeWithIdExistsAsync(request.RecipeId))
        {
            logger.LogError("Recipe with id {RecipeId} not found", request.RecipeId);
            throw new RecipeNotFoundException("Recipe not found");
        }

        if (await recipeUserRepository.UserInRecipeAsync(request.RecipeId, newUser.Id))
        {
            logger.LogError("User with id {UserId} is already in recipe with id {RecipeId}", newUser.Id, request.RecipeId);
            throw new InvalidOperationException("User is already in this recipe");
        }

        var recipeUser = await recipeUserRepository.GetRecipeUserByRecipeIdAndUserIdAsync(request.RecipeId, userId);

        if (recipeUser is not { IsOwner: true })
        {
            logger.LogError("User with id {UserId} is not authorized to add users to recipe with id {RecipeId}", userId, request.RecipeId);
            throw new UnauthorizedAccessException("User is not authorized to add users to this recipe");
        }

        var newRecipeUser = new RecipeUser
        {
            RecipeId = request.RecipeId,
            UserId = newUser.Id,
            IsOwner = false
        };

        await recipeUserRepository.AddRecipeUserAsync(newRecipeUser);
    }

    public async Task RemoveUserFromRecipeAsync(Guid recipeId, Guid userId, Guid userToRemoveId)
    {
        if (!await recipeRepository.RecipeWithIdExistsAsync(recipeId))
        {
            logger.LogError("Recipe with id {RecipeId} not found", recipeId);
            throw new RecipeNotFoundException("Recipe not found");
        }

        var recipeUser = await recipeUserRepository.GetRecipeUserByRecipeIdAndUserIdAsync(recipeId, userId);

        if (recipeUser is not { IsOwner: true })
        {
            logger.LogError("User with id {UserId} is not authorized to remove users from recipe with id {RecipeId}", userId, recipeId);
            throw new UnauthorizedAccessException("User is not authorized to remove users from this recipe");
        }


        var userToRemoveRecipeUser = await recipeUserRepository.GetRecipeUserByRecipeIdAndUserIdAsync(recipeId, userToRemoveId);

        if (userToRemoveRecipeUser is null)
        {
            logger.LogError("User with id {UserToRemoveId} is not in recipe with id {RecipeId}", userToRemoveId, recipeId);
            throw new InvalidOperationException("User is not in this recipe");
        }

        if (userToRemoveRecipeUser.IsOwner && userToRemoveId == userId)
        {
            logger.LogError("User with id {UserToRemoveId} is the owner of recipe with id {RecipeId} and cannot be removed", userToRemoveId, recipeId);
            throw new InvalidOperationException("Owner of the recipe cannot be removed");
        }

        await recipeUserRepository.DeleteUserFromRecipeAsync(userToRemoveRecipeUser);
    }
}

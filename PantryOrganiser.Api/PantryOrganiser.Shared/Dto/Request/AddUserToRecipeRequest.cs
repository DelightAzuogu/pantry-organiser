namespace PantryOrganiser.Shared.Dto.Request;

public class AddUserToRecipeRequest
{
    public string Email { get; set; }

    public Guid RecipeId { get; set; }
}

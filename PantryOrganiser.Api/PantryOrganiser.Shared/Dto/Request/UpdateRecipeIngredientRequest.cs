namespace PantryOrganiser.Shared.Dto.Request;

public class UpdateRecipeIngredientRequest : AddRecipeIngredientRequest
{
    public Guid IngredientId { get; set; }
}

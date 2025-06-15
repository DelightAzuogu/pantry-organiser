using System.Text.Json.Serialization;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Shared.Dto.Request;

public class AddRecipeIngredientRequest
{
    public Guid? RecipeId { get; set; }
    
    public required string Name { get; set; }
    
    public double Quantity { get; set; }
    
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public QuantityUnit QuantityUnit { get; set; }
}
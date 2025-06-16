using System.Text.Json.Serialization;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Shared.Dto.Response;

public class RecipeIngredientResponse
{
    public Guid Id { get; set; }

    public string Name { get; set; }

    public double Quantity { get; set; }

    [JsonConverter(typeof(JsonStringEnumConverter))]
    public QuantityUnit QuantityUnit { get; set; }
}

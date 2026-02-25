using System.Text.Json.Serialization;

namespace PantryOrganiser.Shared.Enum;

[JsonConverter(typeof(JsonStringEnumConverter))] 
public enum QuantityUnit
{
    Count,
    Kilogram,
    Gram,
    Ounce,
    Tablespoon,
    Teaspoon,
    Cup,
}

using System.Text.Json.Serialization;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Domain.Entity;

public class RecipeIngredient : BaseEntity
{
    public Guid RecipeId { get; set; }
    public virtual Recipe Recipe { get; set; }
    
    public string Name { get; set; }
    
    public double Quantity { get; set; }
    
    [JsonConverter(typeof(JsonStringEnumConverter))] 
    public QuantityUnit QuantityUnit { get; set; }
}

using System.Text.Json.Serialization;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Shared.Dto.Request;

public class AddShoppingBasketItem
{
    public string Name  { get; set; }
    public int Quantity { get; set; }
    [JsonConverter(typeof(JsonStringEnumConverter))] 
    public QuantityUnit QuantityUnit { get; set; }
    
    public Guid ShoppingBasketId { get; set; }
}

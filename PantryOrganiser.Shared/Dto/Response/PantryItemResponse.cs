using System.Text.Json.Serialization;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Shared.Dto.Response;

public class PantryItemResponse
{
    public Guid Id { get; set; }
    
    public string Name { get; set; }
    
    public string Description { get; set; }
    
    public double Quantity { get; set; }
    
    [JsonConverter(typeof(JsonStringEnumConverter))] 
    public  QuantityUnit QuantityUnit { get; set; }
    
    public string Brand { get; set; }
    
    public DateTime? ExpiryDate { get; set; }
}

using System.Text.Json.Serialization;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Shared.Dto.Request;

public class AddRolesToUserInPantryRequest
{
    [JsonConverter(typeof(JsonStringEnumConverter))]
    public List<Role> Roles { get; set; }
}

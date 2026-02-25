using System.Text.Json.Serialization;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Shared.Dto.Request;

public class AddRolesToUserInPantryRequest
{
    [JsonConverter(typeof(FlexibleEnumListConverter<Role>))]
    public List<Role> Roles { get; set; }
}

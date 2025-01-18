using System.Text.Json.Serialization;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Shared.Dto;

public class AddUserToPantryRequest
{
    public string Email { get; set; }

    [JsonConverter(typeof(FlexibleEnumListConverter<Role>))]
    public List<Role> Roles { get; set; }
}

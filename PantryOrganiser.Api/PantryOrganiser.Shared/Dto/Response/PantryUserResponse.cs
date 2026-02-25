using System.Text.Json.Serialization;
using PantryOrganiser.Shared.Enum;

namespace PantryOrganiser.Shared.Dto.Response;

public class PantryUserResponse
{
    public string Email { get; set; }

    public Guid PantryUserId { get; set; }

    public Guid UserId { get; set; }
    
    [JsonConverter(typeof(FlexibleEnumListConverter<Role>))]
    public List<Role> Roles { get; set; }
}

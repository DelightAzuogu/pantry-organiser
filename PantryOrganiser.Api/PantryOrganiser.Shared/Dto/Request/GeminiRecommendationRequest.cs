namespace PantryOrganiser.Shared.Dto.Request;

public class GeminiRecommendationRequest
{
    public string Instructions { get; set; }
    public List<Guid> PantryIds { get; set; }
}

namespace PantryOrganiser.Shared.Dto.Response;

public class LoginResponse
{
    public Guid Id { get; set; }
    
    public string Email { get; set; }
    
    public JwtResponse Token { get; set; }
}

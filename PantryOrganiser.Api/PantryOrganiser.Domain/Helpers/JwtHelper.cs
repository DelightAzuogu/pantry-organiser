using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Shared.Constants;
using PantryOrganiser.Shared.Dto.Response;
using PantryOrganiser.Shared.Settings;

namespace PantryOrganiser.Domain.Helpers;

public class JwtHelper(IOptions<WebProtocolSettings> webProtocolSettings) : IJwtHelper
{
    private readonly WebProtocolSettings _webProtocolSettings = webProtocolSettings.Value;

    public JwtResponse GenerateToken(User user)
    {
        return GenerateAccessToken(user);
    }

    private JwtResponse GenerateAccessToken(User user)
    {
        var tokenHandler = new JwtSecurityTokenHandler();

        var tokenKey = Encoding.ASCII.GetBytes(_webProtocolSettings.EncryptionKey);

        var claims = new List<Claim>
        {
            new(ClaimTypes.Email, user.Email),
            new(ClaimTypes.NameIdentifier, user.Id.ToString()),
            new(AuthorisationClaims.FromApplication, _webProtocolSettings.FromApplicationString)
        };

        var tokenDescriptor = new SecurityTokenDescriptor
        {
            Subject = new ClaimsIdentity(claims),
            Expires = DateTime.UtcNow.AddMinutes(_webProtocolSettings.AccessTokenDuration),
            SigningCredentials = new SigningCredentials(
                new SymmetricSecurityKey(tokenKey), SecurityAlgorithms.HmacSha256Signature)
        };

        var token = tokenHandler.CreateToken(tokenDescriptor);

        var tokenString = tokenHandler.WriteToken(token);

        return new JwtResponse
        {
            AccessToken = tokenString
        };
    }
}

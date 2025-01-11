using System.Security.Cryptography;
using System.Text;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.Domain.Helpers;

public class HashHelper : IHashHelper
{
    public bool VerifyHash(string input, string storedHash)
    {
        var newHash = HashString(input);
        return newHash == storedHash;
    }

    public string HashString(string input)
    {
        using var sha256 = SHA256.Create();
        var bytes = Encoding.UTF8.GetBytes(input);
        var hash = sha256.ComputeHash(bytes);
        return Convert.ToBase64String(hash);
    }
}

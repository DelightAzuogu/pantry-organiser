namespace PantryOrganiser.Domain.Interface;

public interface IHashHelper
{
    public bool VerifyHash(string input, string storedHash);
    
    public string HashString(string input);
}

namespace PantryOrganiser.Shared.Settings;

public class WebProtocolSettings
{
    public string Urls { get; set; }
    public string Port { get; set; }
    public List<string> CorsUrls { get; set; }

    public string EncryptionKey { get; set; }

    public double AccessTokenDuration { get; set; }
    public string FromApplicationString { get; set; }
}

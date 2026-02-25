using AspNetCore.AsyncInitialization;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace PantryOrganiser.DataAccess;

public class Initializer(AppDbContext dbContext, ILogger<Initializer> logger)
    : IAsyncInitializer
{
    public async Task InitializeAsync()
    {
        try
        {
            logger.LogInformation("Initializing the database.");
            await dbContext.Database.MigrateAsync();
        }
        catch (Exception e)
        {
            logger.LogError(e.Message, e);
        }
    }
}

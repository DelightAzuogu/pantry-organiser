using AspNetCore.AsyncInitialization;
using PantryOrganiser.Api.Extensions;
using PantryOrganiser.Shared.Constants;

namespace PantryOrganiser.Api;

public class Program
{
    public static async Task Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        var config = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json", false)
            .AddJsonFile($"appsettings.{Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT")}.json", true)
            .AddJsonFile("appsettings.Local.json", true)
            .Build();

        // Add services to the container
        builder.Services.AddApplicationServices(builder.Configuration);

        var app = builder.Build();

        // Configure Swagger UI
        if (app.Environment.IsDevelopment())
        {
            app.UseSwagger();
            app.UseSwaggerUI(c => { c.SwaggerEndpoint("/swagger/v1/swagger.json", "Pantry Organiser API V1"); });
        }

        // Perform async initialization
        using (var scope = app.Services.CreateScope())
        {
            var services = scope.ServiceProvider;
            var initializer = services.GetRequiredService<IAsyncInitializer>();
            await initializer.InitializeAsync();
        }

        app.UseHttpsRedirection();
        app.UseRouting();
        app.UseCors(CorsPolicy.AllowSitesFromAppSettings);
        app.UseAuthentication();
        app.UseAuthorization();
        app.MapControllers();

        await app.RunAsync();
    }
}

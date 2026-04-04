using Amazon.Lambda.AspNetCoreServer;
using AspNetCore.AsyncInitialization;
using PantryOrganiser.Api.Extensions;
using PantryOrganiser.Shared.Constants;

namespace PantryOrganiser.Api
{
    public class LambdaEntryPoint : APIGatewayProxyFunction
    {
        protected override void Init(IWebHostBuilder builder)
        {
            builder.UseStartup<StartupShim>();
        }
    }

    public class StartupShim
    {
        public void ConfigureServices(IServiceCollection services)
        {
            var builder = WebApplication.CreateBuilder();
            
            builder.Configuration
                .AddJsonFile("appsettings.json", optional: false)
                .AddJsonFile($"appsettings.{Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT")}.json", optional: true)
                .AddJsonFile("appsettings.Lambda.json", optional: true)
                .AddEnvironmentVariables();


            services.AddApplicationServices(builder.Configuration);

            var app = builder.Build();

            using (var scope = app.Services.CreateScope())
            {
                var sp = scope.ServiceProvider;
                var initializer = sp.GetRequiredService<IAsyncInitializer>();
                initializer.InitializeAsync().GetAwaiter().GetResult();
            }
        }

        public void Configure(WebApplication app)
        {
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI(c => { c.SwaggerEndpoint("/swagger/v1/swagger.json", "Pantry Organiser API V1"); });
            }

            app.UseHttpsRedirection();
            app.UseRouting();
            app.UseCors(CorsPolicy.AllowSitesFromAppSettings);
            app.UseAuthentication();
            app.UseAuthorization();
            app.MapControllers();
        }
    }
}
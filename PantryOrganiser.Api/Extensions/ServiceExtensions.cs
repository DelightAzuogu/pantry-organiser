using System.Security.Claims;
using System.Text;
using AspNetCore.AsyncInitialization;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using PantryOrganiser.DataAccess;
using PantryOrganiser.DataAccess.Repository;
using PantryOrganiser.Domain.Context;
using PantryOrganiser.Domain.Helpers;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Constants;
using PantryOrganiser.Shared.Settings;

namespace PantryOrganiser.Api.Extensions;

public static class ServiceExtensions
{
    public static IServiceCollection AddApplicationServices(this IServiceCollection services, IConfiguration configuration)
    {
        // Add AppSettings Objects
        services.Configure<WebProtocolSettings>(configuration.GetSection("WebProtocolSettings"));

        // Get protocol settings
        var protocols = new WebProtocolSettings();
        configuration.GetSection("WebProtocolSettings").Bind(protocols);

        // Add Core Services
        services.AddControllers();
        services.AddControllersWithViews();
        services.AddEndpointsApiExplorer();

        // Add Swagger
        services.AddSwagger();
        
        // Add Database
        services.AddDbContext<AppDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("ApplicationDbContext")));

        // Add Repositories
        services.AddRepositories();

        // Add Services
        services.AddBusinessServices();

        // Add Authentication
        services.AddAuthentication(protocols);

        // Add CORS
        services.AddCors();

        // Add User Context
        services.AddUserContext();

        return services;
    }

    private static void AddUserContext(this IServiceCollection services)
    {
        services.AddHttpContextAccessor();
        services.AddScoped<IUserContext, UserContext>((Func<IServiceProvider, UserContext>)(c =>
        {
            UserContext userContext = GetUserContextFromClaims(c.GetService<IHttpContextAccessor>().HttpContext?.User);
            return userContext;
        }));
    }

    private static UserContext GetUserContextFromClaims(ClaimsPrincipal claimsPrincipal)
    {
        if (claimsPrincipal == null)
            return new UserContext();

        var userId = ((ClaimsIdentity)claimsPrincipal.Identity)
            .Claims
            .Where(c => c.Type == ClaimTypes.NameIdentifier)
            .Select(c => Guid.Parse(c.Value))
            .FirstOrDefault();
        var email = ((ClaimsIdentity)claimsPrincipal.Identity)
            .Claims
            .Where(c => c.Type == ClaimTypes.Email)
            .Select(c => c.Value)
            .FirstOrDefault();

        return new UserContext
        {
            Email = email,
            UserId = userId
        };
    }

    private static void AddSwagger(this IServiceCollection services)
    {
        services.AddSwaggerGen(c =>
        {
            c.SwaggerDoc("v1", new OpenApiInfo
            {
                Title = "Pantry Organiser API",
                Version = "v1",
                Description = "API for managing pantry organization"
            });

            c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
            {
                Description = "JWT Authorization header using the Bearer scheme. Enter 'Bearer' [space] and then your token in the text input below.",
                Name = "Authorization",
                In = ParameterLocation.Header,
                Type = SecuritySchemeType.ApiKey,
                Scheme = "Bearer"
            });

            c.AddSecurityRequirement(new OpenApiSecurityRequirement
            {
                {
                    new OpenApiSecurityScheme
                    {
                        Reference = new OpenApiReference
                        {
                            Type = ReferenceType.SecurityScheme,
                            Id = "Bearer"
                        }
                    },
                    Array.Empty<string>()
                }
            });
        });
    }

    private static void AddRepositories(this IServiceCollection services)
    {
        services.AddTransient(typeof(IBaseRepository<>), typeof(BaseRepository<>));
        services.AddScoped<IUserRepository, UserRepository>();
        services.AddScoped<IAsyncInitializer, Initializer>();
    }

    private static void AddBusinessServices(this IServiceCollection services)
    {
        services.AddScoped<IUserService, UserService>();
        services.AddSingleton<IJwtHelper, JwtHelper>();
        services.AddSingleton<IHashHelper, HashHelper>();
    }

    private static void AddAuthentication(this IServiceCollection services, WebProtocolSettings protocols)
    {
        services.AddAuthentication(x =>
            {
                x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            })
            .AddJwtBearer(AuthorisationPolicies.JwtBearers, x =>
            {
                x.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(protocols.EncryptionKey)),
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    ValidateLifetime = true,
                    ClockSkew = TimeSpan.Zero
                };
            });

        services.AddAuthorization(options =>
        {
            options.AddPolicy(AuthorisationPolicies.Users, policy =>
            {
                policy.RequireClaim(AuthorisationClaims.FromApplication, protocols.FromApplicationString)
                    .AddAuthenticationSchemes(AuthorisationPolicies.JwtBearers);
            });
        });
    }

    private static void AddCors(this IServiceCollection services)
    {
        services.AddCors(options =>
        {
            options.AddPolicy(CorsPolicy.AllowSitesFromAppSettings, x =>
            {
                x.AllowAnyOrigin()
                    .AllowAnyHeader()
                    .AllowAnyMethod();
            });
        });
    }
}

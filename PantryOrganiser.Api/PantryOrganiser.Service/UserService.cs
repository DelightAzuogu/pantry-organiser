using Microsoft.AspNetCore.Identity.Data;
using Microsoft.Extensions.Logging;
using PantryOrganiser.Domain.Entity;
using PantryOrganiser.Domain.Interface;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Constants;
using PantryOrganiser.Shared.Dto.Request;
using PantryOrganiser.Shared.Dto.Response;
using PantryOrganiser.Shared.Exceptions;

namespace PantryOrganiser.Service;

public class UserService(ILogger<UserService> logger, IUserRepository userRepository, IHashHelper hashHelper, IJwtHelper jwtHelper) : IUserService
{
    public async Task<LoginResponse> LoginAsync(LoginRequestDto request)
    {
        var user = await userRepository.GetUserByEmailAsync(request.Email);
        if (user is null)
        {
            logger.LogError($"User with email {request.Email} not found.");
            throw new UserNotFoundException(ResponseMessages.UserNotFound);
        }

        if (!hashHelper.VerifyHash(request.Password, user.PasswordHash))
        {
            logger.LogError($"User with email {request.Email} provided an incorrect password.");
            throw new InvalidPasswordException(ResponseMessages.InvalidPassword);
        }

        logger.LogInformation("Generating token for user with id {Id}", user.Id);

        var token = jwtHelper.GenerateToken(user);

        return new LoginResponse
        {
            Id = user.Id,
            Email = user.Email,
            Token = token
        };
    }

    public async Task<LoginResponse> RegisterAsync(RegisterRequest request)
    {
        logger.LogInformation("checking if user with email already exists.");
        if (await userRepository.UserWithEmailExistsAsync(request.Email))
        {
            logger.LogError($"User with email {request.Email} already exists.");
            throw new UserAlreadyExistsException(ResponseMessages.UserAlreadyExists);
        }

        logger.LogInformation("Creating new user");

        var user = new User
        {
            Email = request.Email,
            PasswordHash = hashHelper.HashString(request.Password)
        };

        await userRepository.AddUserAsync(user);

        logger.LogInformation("User created with id {Id}", user.Id);

        logger.LogInformation("Generating token for user with id {Id}", user.Id);

        var token = jwtHelper.GenerateToken(user);

        logger.LogInformation("Token generated for user with id {Id}", user.Id);

        return new LoginResponse
        {
            Id = user.Id,
            Email = user.Email,
            Token = token
        };
    }

    public async Task ValidateUserExistenceByIdAsync(Guid userId)
    {
        logger.LogInformation("Checking if user with id {Id} exists.", userId);
        if (!await userRepository.UserWithIdExistsAsync(userId))
        {
            logger.LogError($"User with id {userId} not found.");
            throw new UserNotFoundException(ResponseMessages.UserNotFound);
        }
    }

    public async Task ValidateUserExistenceByEmailAsync(string email)
    {
        logger.LogInformation("Checking if user with email {email} exists.", email);
        if (!await userRepository.UserWithEmailExistsAsync(email))
        {
            logger.LogError($"User with email {email} not found.");
            throw new UserNotFoundException(ResponseMessages.UserNotFound);
        }
    }

    public async Task<User> GetUserByEmailAsync(string email)
    {
        logger.LogInformation("Getting user with email {email}.", email);
        var user = await userRepository.GetUserByEmailAsync(email);

        if (user is null)
        {
            logger.LogError($"User with email {email} not found.");
            throw new UserNotFoundException(ResponseMessages.UserNotFound);
        }

        return user;
    }

    public async Task<User> GetUserByIdAsync(Guid userId)
    {
        logger.LogInformation("Getting user with id {Id}.", userId);
        var user = await userRepository.GetUserByIdAsync(userId);
        if (user is null)
        {
            logger.LogError($"User with id {userId} not found.");
            throw new UserNotFoundException(ResponseMessages.UserNotFound);
        }

        return user;
    }
}

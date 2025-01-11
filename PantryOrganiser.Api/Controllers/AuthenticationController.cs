﻿using Microsoft.AspNetCore.Identity.Data;
using Microsoft.AspNetCore.Mvc;
using PantryOrganiser.Service.Interfaces;
using PantryOrganiser.Shared.Constants;
using PantryOrganiser.Shared.Exceptions;
using LoginRequest = PantryOrganiser.Shared.Dto.Request.LoginRequest;

namespace PantryOrganiser.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class AuthenticationController(ILogger<AuthenticationController> logger, IUserService userService) : ControllerBase
{
    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginRequest request)
    {
        try
        {
            var response = await userService.LoginAsync(request);

            return Ok(response);
        }
        catch (UserNotFoundException e)
        {
            logger.LogError(e.Message, e);
            return NotFound(e.Message);
        }
        catch (InvalidPasswordException e)
        {
            logger.LogError(e.Message, e);
            return BadRequest(e.Message);
        }
        catch (Exception e)
        {
            logger.LogError(e.Message, e);
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }
    
    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] RegisterRequest request)
    {
        try
        {
            var response = await userService.RegisterAsync(request);

            return Ok(response);
        }
        catch (UserAlreadyExistsException e)
        {
            logger.LogError(e.Message, e);
            return Conflict(e.Message);
        }
        catch (Exception e)
        {
            logger.LogError(e.Message, e);
            return StatusCode(StatusCodes.Status500InternalServerError);
        }
    }
}

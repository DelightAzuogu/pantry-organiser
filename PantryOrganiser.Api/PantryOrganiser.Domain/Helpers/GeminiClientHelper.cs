using AutoGen.Core;
using AutoGen.Gemini;
using Microsoft.Extensions.Logging;
using PantryOrganiser.Domain.Interface;

namespace PantryOrganiser.Domain.Helpers;

public class GeminiClientHelper : IGeminiClientHelper
{
    private readonly ILogger<GeminiClientHelper> _logger;
    private readonly MiddlewareStreamingAgent<GeminiChatAgent> _geminiChatAgent;

    public GeminiClientHelper(ILogger<GeminiClientHelper> logger, string apiKey)
    {
        _logger = logger ?? throw new ArgumentNullException(nameof(logger));

        if (string.IsNullOrWhiteSpace(apiKey))
        {
            throw new ArgumentException("API Key cannot be null or empty", nameof(apiKey));
        }

        _logger.LogInformation("Initializing GeminiClientHelper with provided API key.");
        _geminiChatAgent = new GeminiChatAgent(
                "gemini",
                "gemini-2.5-flash",
                apiKey,
                systemMessage:
                "You are a multi-country chef, that can cook recipes from any country in the world. You are to provide recipes based on the ingredients provided by the user. You will provide the recipe in a step by step format, with each step numbered. You will also provide a list of ingredients required for the recipe. You will not provide any additional information or commentary. You will only provide the recipe and the list of ingredients. You can also add youtube video links .If you do not know the answer, you will say 'I do not know'.")
            .RegisterMessageConnector()
            .RegisterPrintMessage();
    }

    public async Task<IMessage> CallGeminiAsync(string query)
    {
        if (string.IsNullOrWhiteSpace(query))
        {
            _logger.LogError("Gemini query is empty");
            throw new ArgumentException("Query cannot be null or whitespace.", nameof(query));
        }

        try
        {
            _logger.LogInformation("Gemini query: {query}", query);
            var response = await _geminiChatAgent.SendAsync(query);
            return response;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error calling Gemini API");
            throw new Exception("Error calling Gemini API", ex);
        }
    }
}

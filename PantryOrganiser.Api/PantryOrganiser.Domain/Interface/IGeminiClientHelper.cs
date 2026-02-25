using AutoGen.Core;

namespace PantryOrganiser.Domain.Interface;

public interface IGeminiClientHelper
{
    Task<IMessage> CallGeminiAsync(string query);
}

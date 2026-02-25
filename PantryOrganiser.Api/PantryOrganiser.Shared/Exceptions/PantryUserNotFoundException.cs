using System.Runtime.Serialization;

namespace PantryOrganiser.Shared.Exceptions;

public class PantryUserNotFoundException : Exception
{
    public PantryUserNotFoundException()
    {
    }

    public PantryUserNotFoundException(string message) : base(message)
    {
    }

    public PantryUserNotFoundException(string message, Exception innerException) : base(message, innerException)
    {
    }

    protected PantryUserNotFoundException(SerializationInfo info, StreamingContext context) : base(info, context)
    {
    }
}
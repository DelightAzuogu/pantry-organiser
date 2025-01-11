using System.Runtime.Serialization;

namespace PantryOrganiser.Shared.Exceptions;

public class PantryItemNotFoundException : Exception
{
    public PantryItemNotFoundException()
    {
    }

    public PantryItemNotFoundException(string message) : base(message)
    {
    }

    public PantryItemNotFoundException(string message, Exception innerException) : base(message, innerException)
    {
    }

    protected PantryItemNotFoundException(SerializationInfo info, StreamingContext context) : base(info, context)
    {
    }
}

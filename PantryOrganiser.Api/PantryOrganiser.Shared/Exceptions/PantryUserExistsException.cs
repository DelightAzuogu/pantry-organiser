using System.Runtime.Serialization;

namespace PantryOrganiser.Shared.Exceptions;

public class PantryUserExistsException : Exception
{
    public PantryUserExistsException()
    {
    }

    public PantryUserExistsException(string message) : base(message)
    {
    }

    public PantryUserExistsException(string message, Exception innerException) : base(message, innerException)
    {
    }

    protected PantryUserExistsException(SerializationInfo info, StreamingContext context) : base(info, context)
    {
    }
}

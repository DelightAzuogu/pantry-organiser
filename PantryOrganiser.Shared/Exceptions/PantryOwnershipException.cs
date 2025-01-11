using System.Runtime.Serialization;

namespace PantryOrganiser.Shared.Exceptions;

public class PantryOwnershipException : Exception
{
    public PantryOwnershipException()
    {
    }

    public PantryOwnershipException(string message) : base(message)
    {
    }

    public PantryOwnershipException(string message, Exception innerException) : base(message, innerException)
    {
    }

    protected PantryOwnershipException(SerializationInfo info, StreamingContext context) : base(info, context)
    {
    }
}

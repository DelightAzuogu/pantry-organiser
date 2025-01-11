using System.Runtime.Serialization;

namespace PantryOrganiser.Shared.Exceptions;

public class PantryItemOwnershipException : Exception
{
    public PantryItemOwnershipException()
    {
    }

    public PantryItemOwnershipException(string message) : base(message)
    {
    }

    public PantryItemOwnershipException(string message, Exception innerException) : base(message, innerException)
    {
    }

    protected PantryItemOwnershipException(SerializationInfo info, StreamingContext context) : base(info, context)
    {
    }
}

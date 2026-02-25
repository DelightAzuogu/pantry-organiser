using System.Runtime.Serialization;

namespace PantryOrganiser.Shared.Exceptions;

public class PantryRoleNotFoundException : Exception
{
    public PantryRoleNotFoundException()
    {
    }

    public PantryRoleNotFoundException(string message) : base(message)
    {
    }

    public PantryRoleNotFoundException(string message, Exception innerException) : base(message, innerException)
    {
    }

    protected PantryRoleNotFoundException(SerializationInfo info, StreamingContext context) : base(info, context)
    {
    }
}

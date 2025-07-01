using System.Runtime.Serialization;

namespace PantryOrganiser.Shared.Exceptions;

public class ShoppingBasketNotFoundException : Exception
{
    public ShoppingBasketNotFoundException()
    {
    }

    public ShoppingBasketNotFoundException(string message) : base(message)
    {
    }

    public ShoppingBasketNotFoundException(string message, Exception innerException) : base(message, innerException)
    {
    }

    protected ShoppingBasketNotFoundException(SerializationInfo info, StreamingContext context) : base(info, context)
    {
    }
}

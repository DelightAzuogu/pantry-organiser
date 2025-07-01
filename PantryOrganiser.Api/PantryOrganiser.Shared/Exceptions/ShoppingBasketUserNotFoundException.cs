using System.Runtime.Serialization;

namespace PantryOrganiser.Shared.Exceptions;

public class ShoppingBasketUserNotFoundException : Exception
{
    public ShoppingBasketUserNotFoundException()
    {
    }

    public ShoppingBasketUserNotFoundException(string message) : base(message)
    {
    }

    public ShoppingBasketUserNotFoundException(string message, Exception innerException) : base(message, innerException)
    {
    }

    protected ShoppingBasketUserNotFoundException(SerializationInfo info, StreamingContext context) : base(info, context)
    {
    }
}

using System.Runtime.Serialization;

namespace PantryOrganiser.Shared.Exceptions;

public class ShoppingBasketItemNotFoundException : Exception
{
    public ShoppingBasketItemNotFoundException()
    {
    }

    public ShoppingBasketItemNotFoundException(string message) : base(message)
    {
    }

    public ShoppingBasketItemNotFoundException(string message, Exception innerException) : base(message, innerException)
    {
    }

    protected ShoppingBasketItemNotFoundException(SerializationInfo info, StreamingContext context) : base(info, context)
    {
    }
}

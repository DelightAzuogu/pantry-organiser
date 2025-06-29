﻿using System.Runtime.Serialization;

namespace PantryOrganiser.Shared.Exceptions;

public class IngredientNotFoundException : Exception
{
    public IngredientNotFoundException()
    {
    }

    public IngredientNotFoundException(string message) : base(message)
    {
    }

    public IngredientNotFoundException(string message, Exception innerException) : base(message, innerException)
    {
    }

    protected IngredientNotFoundException(SerializationInfo info, StreamingContext context) : base(info, context)
    {
    }
}

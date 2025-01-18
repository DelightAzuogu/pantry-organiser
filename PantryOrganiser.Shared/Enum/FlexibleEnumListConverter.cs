namespace PantryOrganiser.Shared.Enum;

using System;
using System.Collections.Generic;
using System.Text.Json;
using System.Text.Json.Serialization;

public class FlexibleEnumListConverter<T> : JsonConverter<List<T>> where T : struct, Enum
{
    public override List<T> Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        if (reader.TokenType != JsonTokenType.StartArray)
        {
            throw new JsonException("Expected start of array");
        }

        var results = new List<T>();

        while (reader.Read())
        {
            if (reader.TokenType == JsonTokenType.EndArray)
            {
                break;
            }

            if (reader.TokenType == JsonTokenType.String)
            {
                string enumString = reader.GetString();
                if (Enum.TryParse<T>(enumString, true, out T enumValue))
                {
                    results.Add(enumValue);
                }
                else
                {
                    throw new JsonException($"Unable to convert '{enumString}' to enum type {typeof(T)}");
                }
            }
        }

        return results;
    }

    public override void Write(Utf8JsonWriter writer, List<T> value, JsonSerializerOptions options)
    {
        writer.WriteStartArray();
        foreach (var item in value)
        {
            writer.WriteStringValue(item.ToString());
        }
        writer.WriteEndArray();
    }
}

defmodule TypeLeapWeb.Components.LlmProvider do
  @api_endpoint "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-lite:generateContent?key="
  @key System.get_env("GEMINI_API_KEY", "")

  def get_json_response(prompt, schema) do
    prompt
    |> build_json_request(schema)
    |> make_json_request()
    |> handle_json_response()
  end

  defp build_json_request(prompt, schema) do
    %{
      generationConfig: %{
        response_mime_type: "application/json",
        response_schema: schema
      },
      contents: %{
        "parts" => [
          %{
            "text" => prompt
          }
        ]
      }
    }
  end

  defp make_json_request(request_json) do
    Req.post!(request_url(),
      headers: headers(),
      json: request_json,
      decode_json: %{keys: :strings}
    )
  end

  defp handle_json_response(response) do
    response.body
    |> Map.get("candidates")
    |> Enum.at(0)
    |> Map.get("content")
    |> Map.get("parts")
    |> Enum.at(0)
    |> Map.get("text")
    |> JSON.decode!()
  end

  defp headers do
    %{
      "Content-Type" => "application/json",
      "Accept" => "application/json"
    }
  end

  defp request_url do
    @api_endpoint <> @key
  end
end

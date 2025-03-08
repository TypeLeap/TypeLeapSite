defmodule TypeLeapWeb.Components.TypeLeapIntent do
  alias TypeLeapWeb.Components.LlmProvider

  def get_intent(input_text) do
    prompt = "The following string a user has entered into a search box.

      The search box can do five functions;
      1) it can answer a question;
      2) it can do a command;
      3) it can add knowledge to the brain; and
      4) it can search for things.
      5) it can navigate to a page or site.

      A question is usually of the form ... *what* or *how* is something. Like *what is the capital of france*. Or, how do I classify this image? or How much did I spend on groceries last month? or if it ends in a question mark, then it's most likely a question.
      An command is usually of the form ... *verb* something. Like *mark all as read*. Or *make a new invoice to bob*
      Adding knowledge is usually of the form ... something *is/are* something. Like *capital of france is paris*. Or All grocies *are* drawings.
      A search is usually shorter, 2-3 words, like *capital france* or *bob* and is usually a noun or noun phrase. If unsure, it's probably a search.
      Navigation is when it's a well known site e.g. facebook or google, or a command like 'go to the home page'
      Out of the five, respond in json which intent the user is aiming for, based on the following user input:

      USER INPUT:
      >>> #{input_text} <<<

      The intent choices are:
      (question | command | knowledge | search | navigate)
      "

    schema = %{
      type: "OBJECT",
      properties: %{
        intent: %{type: "STRING"}
      }
    }

    LlmProvider.get_json_response(prompt, schema)
  end
end

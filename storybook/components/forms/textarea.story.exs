defmodule Storybook.Components.Forms.Textarea do
  use PhoenixStorybook.Story, :component

  def function, do: &ZaqWeb.CoreComponents.input/1

  def description, do: "Multiline textarea rendered via CoreComponents.input/1."

  def variations do
    [
      %VariationGroup{
        id: :multiline,
        description: "Textarea",
        variations: [
          %Variation{
            id: :textarea,
            description: "Textarea",
            attributes: %{
              name: "bio",
              type: "textarea",
              label: "Bio",
              value: "",
              placeholder: "Tell us about yourself…",
              rows: "4"
            }
          }
        ]
      }
    ]
  end
end

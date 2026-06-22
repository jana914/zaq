defmodule Storybook.Components.Forms.Checkbox do
  use PhoenixStorybook.Story, :component

  def function, do: &ZaqWeb.CoreComponents.input/1

  def description, do: "Checkbox input — boolean toggle rendered via CoreComponents.input/1."

  def variations do
    [
      %VariationGroup{
        id: :checkbox,
        description: "Checkbox",
        variations: [
          %Variation{
            id: :checkbox_off,
            description: "Unchecked",
            attributes: %{
              name: "notify",
              type: "checkbox",
              label: "Email notifications",
              value: false
            }
          },
          %Variation{
            id: :checkbox_on,
            description: "Checked",
            attributes: %{
              name: "notify",
              type: "checkbox",
              label: "Email notifications",
              value: true
            }
          }
        ]
      }
    ]
  end
end

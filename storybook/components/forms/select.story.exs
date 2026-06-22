defmodule Storybook.Components.Forms.Select do
  use PhoenixStorybook.Story, :component

  def function, do: &ZaqWeb.CoreComponents.input/1

  def description, do: "Select (dropdown) input rendered via CoreComponents.input/1."

  def variations do
    [
      %VariationGroup{
        id: :select,
        description: "Select",
        variations: [
          %Variation{
            id: :select,
            description: "Select",
            attributes: %{
              name: "role",
              type: "select",
              label: "Role",
              options: [{"Admin", "admin"}, {"User", "user"}, {"Viewer", "viewer"}],
              value: "user"
            }
          }
        ]
      }
    ]
  end
end

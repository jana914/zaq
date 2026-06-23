defmodule Storybook.Components.Forms.Checkbox do
  use PhoenixStorybook.Story, :component

  def function, do: &ZaqWeb.Components.DesignSystem.Checkbox.checkbox/1

  def description,
    do: "Boolean checkbox — labelled for forms, bare for tables and interactive selection."

  def variations do
    [
      %VariationGroup{
        id: :labelled,
        description: "With label",
        variations: [
          %Variation{
            id: :labelled_off,
            description: "Unchecked",
            attributes: %{
              id: "notify",
              name: "notify",
              label: "Email notifications",
              value: false
            }
          },
          %Variation{
            id: :labelled_on,
            description: "Checked",
            attributes: %{
              id: "notify-on",
              name: "notify",
              label: "Email notifications",
              value: true
            }
          },
          %Variation{
            id: :labelled_disabled,
            description: "Disabled",
            attributes: %{
              id: "notify-disabled",
              name: "notify",
              label: "Email notifications",
              value: true,
              disabled: true
            }
          }
        ]
      },
      %VariationGroup{
        id: :bare,
        description: "Without label",
        variations: [
          %Variation{
            id: :bare_off,
            description: "Unchecked",
            attributes: %{
              id: "select-row",
              checked: false
            }
          },
          %Variation{
            id: :bare_on,
            description: "Checked",
            attributes: %{
              id: "select-row-on",
              checked: true
            }
          }
        ]
      },
      %VariationGroup{
        id: :errors,
        description: "With validation errors",
        variations: [
          %Variation{
            id: :with_error,
            description: "Field error",
            attributes: %{
              id: "terms",
              name: "terms",
              label: "Accept terms and conditions",
              value: false,
              errors: ["must be accepted"]
            }
          }
        ]
      }
    ]
  end
end

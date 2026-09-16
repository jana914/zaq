defmodule Storybook.Components.Forms.PasswordRequirements do
  use PhoenixStorybook.Story, :component

  alias Zaq.Accounts.PasswordPolicy

  def function, do: &ZaqWeb.Components.PasswordPolicyComponents.password_requirements/1

  def description,
    do:
      "Inline password-strength requirement checklist with live pass/fail indicators. Place below a secret_input field."

  def variations do
    [
      %VariationGroup{
        id: :states,
        description: "Validation states",
        variations: [
          %Variation{
            id: :empty,
            description: "No password entered",
            attributes: %{
              requirements: PasswordPolicy.requirements_with_status("")
            }
          },
          %Variation{
            id: :partial,
            description: "Partial requirements met",
            attributes: %{
              requirements: PasswordPolicy.requirements_with_status("Strong1")
            }
          },
          %Variation{
            id: :all_met,
            description: "All requirements met",
            attributes: %{
              requirements: PasswordPolicy.requirements_with_status("StrongPass1!")
            }
          }
        ]
      }
    ]
  end
end

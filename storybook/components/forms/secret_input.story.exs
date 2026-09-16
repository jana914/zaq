defmodule Storybook.Components.Forms.SecretInput do
  use PhoenixStorybook.Story, :component

  def function, do: &ZaqWeb.Components.DesignSystem.SecretInput.secret_input/1

  def description,
    do:
      "Password or token field with show/hide toggle, optional field errors, and info/success/error hints. Uses the same .zaq-control-text shell as Input."

  def variations do
    [
      %VariationGroup{
        id: :default,
        description: "Secret input",
        variations: [
          %Variation{
            id: :empty,
            description: "Empty",
            attributes: %{
              id: "api-key",
              name: "api_key",
              label: "API key",
              value: "",
              placeholder: "sk-…"
            }
          },
          %Variation{
            id: :filled,
            description: "Filled",
            attributes: %{
              id: "api-key-filled",
              name: "api_key",
              label: "API key",
              value: "sk-live-xxxxxxxxxxxx"
            }
          }
        ]
      },
      %VariationGroup{
        id: :hints,
        description: "Field hints (shown when there are no validation errors)",
        variations: [
          %Variation{
            id: :hint_info,
            description: "Info hint",
            attributes: %{
              id: "password-info",
              name: "password",
              label: "Password",
              value: "",
              hint: "Use at least 8 characters with mixed case and symbols.",
              hint_tone: :info
            }
          },
          %Variation{
            id: :hint_success,
            description: "Success hint (passwords match)",
            attributes: %{
              id: "password-confirmation",
              name: "password_confirmation",
              label: "Confirm password",
              value: "SecretPass1!",
              hint: "Passwords match",
              hint_tone: :success,
              hint_id: "password-confirmation-status"
            }
          },
          %Variation{
            id: :hint_error,
            description: "Error hint (live feedback, not changeset error)",
            attributes: %{
              id: "password-confirmation-mismatch",
              name: "password_confirmation",
              label: "Confirm password",
              value: "other",
              hint: "Passwords do not match",
              hint_tone: :error,
              hint_id: "password-confirmation-status"
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
              id: "token",
              name: "token",
              label: "Token",
              value: "",
              errors: ["can't be blank"]
            }
          }
        ]
      }
    ]
  end
end

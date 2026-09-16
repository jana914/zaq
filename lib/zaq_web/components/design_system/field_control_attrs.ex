defmodule ZaqWeb.Components.DesignSystem.FieldControlAttrs do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      attr :hint, :string,
        default: nil,
        doc: "Optional helper below the control; hidden when `errors` is non-empty."

      attr :hint_tone, :atom,
        default: :info,
        values: [:info, :success, :error],
        doc: "Visual tone for `hint`."

      attr :hint_id, :string,
        default: nil,
        doc: "Optional stable id for the hint row (tests, `aria-describedby`)."
    end
  end
end

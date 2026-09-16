defmodule ZaqWeb.Components.DesignSystem.EmptyState do
  @moduledoc """
  Centered empty-list or confirmation message for BO panels and auth flows.

  Primary line plus optional hint (e.g. “Click New Person to add one.”).
  Use `variant={:success}` for post-action confirmations (e.g. password-reset sent).
  """

  use Phoenix.Component

  attr :title, :string, required: true
  attr :hint, :string, default: nil
  attr :class, :string, default: ""

  attr :variant, :atom,
    default: :default,
    values: [:default, :success],
    doc: "`:success` adds a centered success icon badge above the title."

  slot :details, doc: "Rich hint body (overrides `hint` when present)."
  slot :action

  def empty_state(assigns) do
    ~H"""
    <div class={["zaq-empty-state", variant_class(@variant), @class]}>
      <div :if={@variant == :success} class="zaq-empty-state-success-icon" aria-hidden="true">
        <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
          <path d="M5 13l4 4L19 7" />
        </svg>
      </div>
      <div class="zaq-layout-stack-tight">
        <p class={title_class(@variant)} style={title_style(@variant)}>
          {@title}
        </p>
        <div :if={@details != []} class={details_class(@variant)} style={details_style(@variant)}>
          {render_slot(@details)}
        </div>
        <p
          :if={@details == [] && @hint}
          class="zaq-text-body-sm"
          style="color: var(--zaq-text-color-body-tertiary)"
        >
          {@hint}
        </p>
        <div :if={@action != []}>
          {render_slot(@action)}
        </div>
      </div>
    </div>
    """
  end

  defp variant_class(:success), do: "zaq-empty-state--success"
  defp variant_class(:default), do: nil

  defp title_class(:success), do: "zaq-text-h4"
  defp title_class(:default), do: "zaq-text-body"

  defp title_style(:success), do: "color: var(--zaq-text-color-body-default)"
  defp title_style(:default), do: "color: var(--zaq-text-color-body-secondary)"

  defp details_class(:success), do: "zaq-text-body"
  defp details_class(:default), do: nil

  defp details_style(:success), do: "color: var(--zaq-text-color-body-secondary)"
  defp details_style(:default), do: nil
end

defmodule ZaqWeb.Components.DesignSystem.AuthLayout do
  @moduledoc """
  Centered auth page shell for BO login and password-reset flows.

  Provides the full-viewport layout, card chrome, and brand header band.
  Page-specific content goes in `:inner_block`; optional `:footer` for copyright.

  Pass `heading` to replace the default “ZAQ / Back Office” title (e.g. change password).
  """

  use Phoenix.Component

  attr :subtitle, :string, required: true

  attr :heading, :string,
    default: nil,
    doc:
      "Optional page title. When set, replaces the default “ZAQ / Back Office” heading (login, forgot password, change password, etc.)."

  slot :header_icon, required: true
  slot :inner_block, required: true
  slot :footer

  def auth_layout(assigns) do
    ~H"""
    <div class="zaq-auth-page">
      <div class="zaq-auth-page-pattern" aria-hidden="true"></div>

      <div class="zaq-auth-shell">
        <div class="zaq-auth-card">
          <div class="zaq-auth-card-header">
            <div class="zaq-auth-logo-badge">
              {render_slot(@header_icon)}
            </div>
            <h1 class="zaq-text-h2 uppercase" style="color: var(--zaq-text-color-body-default)">
              <%= if @heading do %>
                {@heading}
              <% else %>
                ZAQ <span style="color: var(--zaq-text-color-body-accent)">Back Office</span>
              <% end %>
            </h1>
            <p class="zaq-field-label-uppercase zaq-auth-card-subtitle uppercase">
              {@subtitle}
            </p>
          </div>

          <div class="zaq-auth-card-body">
            {render_slot(@inner_block)}
          </div>
        </div>

        <div :if={@footer != []} class="zaq-auth-card-footer">
          {render_slot(@footer)}
        </div>
      </div>
    </div>
    """
  end
end

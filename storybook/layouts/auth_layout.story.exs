defmodule Storybook.Layouts.AuthLayout do
  use PhoenixStorybook.Story, :page
  use Phoenix.Component

  alias ZaqWeb.Components.DesignSystem.AuthLayout
  alias ZaqWeb.Components.DesignSystem.Button, as: DSButton
  alias ZaqWeb.Components.DesignSystem.Input, as: DSInput
  alias ZaqWeb.Components.DesignSystem.Link, as: DSLink

  def description,
    do:
      "Centered auth shell for BO and People sign-in and password-reset (`ZaqWeb.Components.DesignSystem.AuthLayout`)."

  def render(assigns) do
    ~H"""
    <div class="zaq-layout-stack" style="padding: 1rem;">
      <section>
        <h2 class="zaq-text-h4" style="margin-bottom: 0.5rem;">Back Office login</h2>
        <div style="height: 720px; overflow: auto; border: 1px solid rgba(0,0,0,0.08); border-radius: 0.75rem;">
          <AuthLayout.auth_layout subtitle="Authorization Required">
            <:header_icon>
              <img src="/images/zaq.png" alt="ZAQ" class="zaq-auth-logo-img" />
            </:header_icon>

            <.form for={%{}} id="story-auth-login-form" class="zaq-layout-stack">
              <DSInput.input
                name="username"
                label="Username or Email"
                value=""
                placeholder="username or email"
              />
              <DSButton.button type="button" variant={:primary} class="w-full uppercase">
                Sign In to Dashboard
              </DSButton.button>
            </.form>

            <:footer>
              <p class="zaq-text-caption uppercase" style="color: var(--zaq-text-color-body-tertiary)">
                ZAQ Back Office &copy; 2026 |
                <DSLink.nav_link destination="https://zaq.ai" tone={:accent} external={true} size={:sm}>
                  zaq.ai
                </DSLink.nav_link>
              </p>
            </:footer>
          </AuthLayout.auth_layout>
        </div>
      </section>

      <section>
        <h2 class="zaq-text-h4" style="margin-bottom: 0.5rem;">People sign-in (email step)</h2>
        <div style="height: 720px; overflow: auto; border: 1px solid rgba(0,0,0,0.08); border-radius: 0.75rem;">
          <AuthLayout.auth_layout heading="Sign in to ZAQ" subtitle="Authorization Required">
            <:header_icon>
              <img src="/images/zaq.png" alt="ZAQ" class="zaq-auth-logo-img" />
            </:header_icon>

            <p class="zaq-text-body zaq-auth-intro" style="color: var(--zaq-text-color-body-secondary)">
              Use your company email to request a one-time sign-in code.
            </p>

            <.form for={%{}} id="story-people-login-form" class="zaq-layout-stack">
              <DSInput.input
                name="email"
                label="Email address"
                type="email"
                value=""
                placeholder="you@company.com"
              />
              <DSButton.button type="button" variant={:primary} class="w-full uppercase">
                Send sign-in code
              </DSButton.button>
            </.form>
          </AuthLayout.auth_layout>
        </div>
      </section>
    </div>
    """
  end
end

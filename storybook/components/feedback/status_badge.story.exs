defmodule Storybook.Components.Feedback.StatusBadge do
  use PhoenixStorybook.Story, :page

  def description, do: "Inline status pill. Accepts :idle, :loading, :ok, or {:error, message}."

  def render(assigns) do
    ~H"""
    <div style="font-family: var(--zaq-font-primary, monospace); padding: 2rem; display: flex; flex-direction: column; gap: 2rem;">

      <p style="font-size: 0.75rem; opacity: 0.5; font-family: ui-monospace, monospace;">
        &lt;ZaqWeb.Components.BOLayout.status_badge status={:ok} /&gt;
      </p>

      <div style="display: flex; gap: 1.5rem; flex-wrap: wrap; align-items: center;">
        <.demo label=":idle">
          <ZaqWeb.Components.BOLayout.status_badge status={:idle} />
        </.demo>
        <.demo label=":loading">
          <ZaqWeb.Components.BOLayout.status_badge status={:loading} />
        </.demo>
        <.demo label=":ok">
          <ZaqWeb.Components.BOLayout.status_badge status={:ok} />
        </.demo>
        <.demo label="{:error, msg}">
          <ZaqWeb.Components.BOLayout.status_badge status={{:error, "Connection refused"}} />
        </.demo>
      </div>

    </div>
    """
  end

  defp demo(assigns) do
    ~H"""
    <div style="display: flex; flex-direction: column; gap: 0.4rem; align-items: flex-start;">
      <span style="font-size: 0.65rem; font-family: ui-monospace, monospace; opacity: 0.4;"><%= @label %></span>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end

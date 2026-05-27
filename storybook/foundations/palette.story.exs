defmodule Storybook.Foundations.Palette do
  use PhoenixStorybook.Story, :page

  def description, do: "Raw color palette tokens defined in foundations.css — the source values all semantic tokens map to."

  def render(assigns) do
    ~H"""
    <div style="font-family: var(--zaq-font-primary, sans-serif); padding: 2rem; display: flex; flex-direction: column; gap: 3rem;">

      <section>
        <h2 style="font-size: 0.7rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; opacity: 0.45; margin-bottom: 1rem;">Blue</h2>
        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 0.75rem;">
          <.swatch name="blue-400" var="--color-blue-400" />
          <.swatch name="blue-300" var="--color-blue-300" />
          <.swatch name="blue-200" var="--color-blue-200" />
          <.swatch name="blue-100" var="--color-blue-100" />
        </div>
      </section>

      <section>
        <h2 style="font-size: 0.7rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; opacity: 0.45; margin-bottom: 1rem;">Black / Ink</h2>
        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 0.75rem;">
          <.swatch name="black-400" var="--color-black-400" />
          <.swatch name="black-300" var="--color-black-300" />
          <.swatch name="black-200" var="--color-black-200" />
          <.swatch name="black-100" var="--color-black-100" />
        </div>
      </section>

      <section>
        <h2 style="font-size: 0.7rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; opacity: 0.45; margin-bottom: 1rem;">Neutral</h2>
        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 0.75rem;">
          <.swatch name="neutral-400" var="--color-neutral-400" />
          <.swatch name="neutral-300" var="--color-neutral-300" />
          <.swatch name="neutral-200" var="--color-neutral-200" />
          <.swatch name="neutral-100" var="--color-neutral-100" border />
        </div>
      </section>

      <section>
        <h2 style="font-size: 0.7rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; opacity: 0.45; margin-bottom: 1rem;">System</h2>
        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 0.75rem;">
          <.swatch name="system-red"    var="--color-system-red" />
          <.swatch name="system-green"  var="--color-system-green" />
          <.swatch name="system-blue"   var="--color-system-blue" />
          <.swatch name="system-orange" var="--color-system-orange" />
        </div>
      </section>

    </div>
    """
  end

  defp swatch(assigns) do
    ~H"""
    <div style="display: flex; flex-direction: column; gap: 0.4rem;">
      <div style={"height: 48px; border-radius: 8px; background: var(#{@var}); #{if Map.get(assigns, :border), do: "border: 1px solid rgba(0,0,0,0.08);"}"}></div>
      <span style="font-size: 0.7rem; opacity: 0.6; font-family: ui-monospace, monospace;"><%= @name %></span>
      <span style="font-size: 0.65rem; opacity: 0.35; font-family: ui-monospace, monospace;"><%= @var %></span>
    </div>
    """
  end
end

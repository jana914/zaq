defmodule Storybook.Components.Chat.ChatMessage do
  use PhoenixStorybook.Story, :page

  def description, do: "Chat message components — user bubbles, assistant bubbles, feedback buttons, and copy action."

  def render(assigns) do
    ~H"""
    <div style="font-family: var(--zaq-font-primary, monospace); padding: 2rem; display: flex; flex-direction: column; gap: 3rem; max-width: 700px;">

      <%!-- User bubble --%>
      <section>
        <h2 style="font-size: 0.7rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; opacity: 0.45; margin-bottom: 1.5rem;">user_bubble</h2>
        <div style="display: flex; flex-direction: column; gap: 1.5rem;">
          <.demo label="short">
            <ZaqWeb.Components.ChatMessage.user_bubble
              content="What is our refund policy?"
              timestamp={~N[2024-01-15 10:30:00]}
            />
          </.demo>
          <.demo label="long">
            <ZaqWeb.Components.ChatMessage.user_bubble
              content="Can you summarise the key changes in the Q3 product roadmap and tell me which teams are responsible for the new AI features?"
              timestamp={~N[2024-01-15 10:31:00]}
            />
          </.demo>
          <.demo label="multi-line">
            <ZaqWeb.Components.ChatMessage.user_bubble
              content={"I have two questions:\n1. Where is the onboarding checklist?\n2. Who should I contact for IT access?"}
              timestamp={~N[2024-01-15 10:32:00]}
            />
          </.demo>
        </div>
      </section>

      <%!-- Assistant bubble --%>
      <section>
        <h2 style="font-size: 0.7rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; opacity: 0.45; margin-bottom: 1.5rem;">assistant_bubble</h2>
        <div style="display: flex; flex-direction: column; gap: 1.5rem;">
          <.demo label="simple">
            <ZaqWeb.Components.ChatMessage.assistant_bubble
              content="The refund policy allows returns within 30 days of purchase with a valid receipt."
              timestamp={~N[2024-01-15 10:30:05]}
            />
          </.demo>
          <.demo label="with confidence">
            <ZaqWeb.Components.ChatMessage.assistant_bubble
              content="According to the HR handbook, all new employees complete a 90-day onboarding period."
              timestamp={~N[2024-01-15 10:31:05]}
              confidence={0.87}
            />
          </.demo>
          <.demo label="low confidence">
            <ZaqWeb.Components.ChatMessage.assistant_bubble
              content="I found some partial information but the documentation may be incomplete."
              timestamp={~N[2024-01-15 10:32:05]}
              confidence={0.34}
            />
          </.demo>
          <.demo label="with sources">
            <ZaqWeb.Components.ChatMessage.assistant_bubble
              content="The Q3 roadmap introduces three AI features: smart search, auto-tagging, and a conversational assistant."
              timestamp={~N[2024-01-15 10:33:05]}
              confidence={0.92}
              sources={[
                %{"index" => 1, "path" => "documents/q3-roadmap.pdf"},
                %{"index" => 2, "path" => "documents/ai-strategy-2024.pdf"}
              ]}
            />
          </.demo>
          <.demo label="markdown">
            <ZaqWeb.Components.ChatMessage.assistant_bubble
              content={"Here are the key teams:\n\n- **Platform** — infrastructure and APIs\n- **Product** — features and roadmap\n- **Design** — UX and design system\n\nEach team has a dedicated Slack channel."}
              timestamp={~N[2024-01-15 10:34:05]}
              confidence={0.79}
            />
          </.demo>
          <.demo label="error state">
            <ZaqWeb.Components.ChatMessage.assistant_bubble
              content="I was unable to find relevant information in the knowledge base for this query."
              timestamp={~N[2024-01-15 10:35:05]}
              is_error={true}
            />
          </.demo>
        </div>
      </section>

      <%!-- Feedback buttons --%>
      <section>
        <h2 style="font-size: 0.7rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; opacity: 0.45; margin-bottom: 1.5rem;">feedback buttons</h2>
        <div style="display: flex; gap: 2rem; flex-wrap: wrap; align-items: center;">
          <.demo label="positive — unrated">
            <ZaqWeb.Components.ChatMessage.feedback_positive_button message_id="msg-001" feedback={nil} />
          </.demo>
          <.demo label="positive — rated">
            <ZaqWeb.Components.ChatMessage.feedback_positive_button message_id="msg-002" feedback={:positive} />
          </.demo>
          <.demo label="negative — unrated">
            <ZaqWeb.Components.ChatMessage.feedback_negative_button message_id="msg-003" feedback={nil} />
          </.demo>
          <.demo label="negative — rated">
            <ZaqWeb.Components.ChatMessage.feedback_negative_button message_id="msg-004" feedback={:negative} />
          </.demo>
        </div>
      </section>

      <%!-- Copy button --%>
      <section>
        <h2 style="font-size: 0.7rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; opacity: 0.45; margin-bottom: 1.5rem;">copy_action_button</h2>
        <.demo label="default">
          <ZaqWeb.Components.ChatMessage.copy_action_button text="The refund policy allows returns within 30 days." />
        </.demo>
      </section>

    </div>
    """
  end

  defp demo(assigns) do
    ~H"""
    <div style="display: flex; flex-direction: column; gap: 0.4rem;">
      <span style="font-size: 0.65rem; font-family: ui-monospace, monospace; opacity: 0.4;"><%= @label %></span>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end

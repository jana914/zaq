defmodule ZaqWeb.Dashboard.MetricOverview do
  @moduledoc """
  BO main dashboard — KPI metric cards grid and deep links to metric sub-pages.
  """

  use Phoenix.Component

  import ZaqWeb.Components.BOTelemetryComponents, only: [metric_card: 1]
  import ZaqWeb.Components.DesignSystem.Link, only: [nav_link: 1]

  attr :metric_cards, :list, required: true

  def metric_overview(assigns) do
    ~H"""
    <div class="mb-8 grid grid-cols-1 gap-4 md:grid-cols-2 xl:grid-cols-3">
      <div :for={metric <- @metric_cards} class="space-y-2">
        <.link
          id={metric.id}
          navigate={metric.runtime.href || "/bo/dashboard"}
          class="group block"
        >
          <.metric_card id={metric.id <> "-card"} card={metric} />
        </.link>

        <.nav_link
          :if={metric.id == "dashboard-metric-documents-ingested"}
          id="dashboard-knowledge-base-metrics-link"
          destination="/bo/dashboard/knowledge-base-metrics"
          tone={:accent}
          size={:sm}
          icon="hero-arrow-right"
          icon_position={:right}
        >
          View Knowledge base metrics
        </.nav_link>

        <.nav_link
          :if={metric.id == "dashboard-metric-llm-api-calls"}
          id="dashboard-llm-performance-link"
          destination="/bo/dashboard/llm-performance"
          tone={:accent}
          size={:sm}
          icon="hero-arrow-right"
          icon_position={:right}
        >
          View LLM performance
        </.nav_link>

        <.nav_link
          :if={metric.id == "dashboard-metric-qa-response-time"}
          id="dashboard-conversations-metrics-link"
          destination="/bo/dashboard/conversations-metrics"
          tone={:accent}
          size={:sm}
          icon="hero-arrow-right"
          icon_position={:right}
        >
          View Conversations metrics
        </.nav_link>
      </div>
    </div>
    """
  end
end

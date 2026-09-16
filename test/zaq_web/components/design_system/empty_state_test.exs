defmodule ZaqWeb.Components.DesignSystem.EmptyStateTest do
  use ZaqWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias ZaqWeb.Components.DesignSystem.EmptyState

  test "empty_state/1 renders title" do
    html = render_component(&EmptyState.empty_state/1, title: "No people yet.")

    assert html =~ "No people yet."
  end

  test "empty_state/1 renders optional hint" do
    html =
      render_component(&EmptyState.empty_state/1,
        title: "No teams yet.",
        hint: "Click \"New Team\" to add one."
      )

    assert html =~ "No teams yet."
    assert html =~ "Click &quot;New Team&quot; to add one."
  end

  test "empty_state/1 renders optional action" do
    html =
      render_component(&EmptyState.empty_state/1,
        title: "No data source enabled.",
        action: [%{inner_block: fn _, _ -> "Enable a data source" end}]
      )

    assert html =~ "No data source enabled."
    assert html =~ "Enable a data source"
  end

  test "empty_state/1 success variant renders icon badge and details slot" do
    html =
      render_component(&EmptyState.empty_state/1,
        variant: :success,
        title: "Check your inbox",
        details: [
          %{
            inner_block: fn _, _ ->
              Phoenix.HTML.raw("The link is valid for <strong>1 hour</strong>.")
            end
          }
        ],
        action: [%{inner_block: fn _, _ -> "Back to Sign In" end}]
      )

    assert html =~ "zaq-empty-state--success"
    assert html =~ "Check your inbox"
    assert html =~ "1 hour"
    assert html =~ "Back to Sign In"
  end
end

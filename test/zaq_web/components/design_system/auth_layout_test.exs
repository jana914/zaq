defmodule ZaqWeb.Components.DesignSystem.AuthLayoutTest do
  use ZaqWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias ZaqWeb.Components.DesignSystem.AuthLayout

  test "auth_layout/1 renders subtitle and inner content" do
    html =
      render_component(&AuthLayout.auth_layout/1,
        subtitle: "Authorization Required",
        header_icon: [%{inner_block: fn _, _ -> "ICON" end}],
        inner_block: [%{inner_block: fn _, _ -> "BODY" end}]
      )

    assert html =~ "Authorization Required"
    assert html =~ "ZAQ"
    assert html =~ "Back Office"
    assert html =~ "zaq-auth-page"
    assert html =~ "ICON"
    assert html =~ "BODY"
  end

  test "auth_layout/1 renders optional footer slot" do
    html =
      render_component(&AuthLayout.auth_layout/1,
        subtitle: "Password Reset",
        header_icon: [%{inner_block: fn _, _ -> "ICON" end}],
        inner_block: [%{inner_block: fn _, _ -> "BODY" end}],
        footer: [%{inner_block: fn _, _ -> "FOOTER" end}]
      )

    assert html =~ "FOOTER"
  end
end

defmodule ZaqWeb.Components.PasswordPolicyComponentsTest do
  use ZaqWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias Zaq.Accounts.PasswordPolicy
  alias ZaqWeb.Components.PasswordPolicyComponents

  test "password_requirements/1 renders stable ids and labels" do
    requirements = PasswordPolicy.requirements_with_status("")

    html =
      render_component(&PasswordPolicyComponents.password_requirements/1,
        requirements: requirements
      )

    assert html =~ ~s(id="password-requirements")
    assert html =~ ~s(id="password-requirement-min_length")
    assert html =~ "At least 8 characters"
    assert html =~ "Password Requirements"
    assert html =~ "zaq-password-requirements"
  end

  test "password_requirements/1 honors custom id and title" do
    html =
      render_component(&PasswordPolicyComponents.password_requirements/1,
        id: "custom-requirements",
        title: "Rules",
        requirements: [%{id: :symbol, label: "Symbol", met?: false}]
      )

    assert html =~ ~s(id="custom-requirements")
    assert html =~ "Rules"
    assert html =~ ~s(id="password-requirement-symbol")
    assert html =~ "zaq-password-requirements__row--unmet"
  end

  test "password_requirements/1 marks met rows with success class" do
    html =
      render_component(&PasswordPolicyComponents.password_requirements/1,
        requirements: PasswordPolicy.requirements_with_status("StrongPass1!")
      )

    assert html =~ ~s(id="password-requirement-digit")
    assert html =~ "zaq-password-requirements__row--met"
  end
end

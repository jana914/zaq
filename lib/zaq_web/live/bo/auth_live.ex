defmodule ZaqWeb.Live.BO.AuthLive do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      alias ZaqWeb.Components.DesignSystem.AuthLayout
      alias ZaqWeb.Components.DesignSystem.Button, as: DSButton
      alias ZaqWeb.Components.DesignSystem.Input, as: DSInput
      alias ZaqWeb.Components.DesignSystem.Link, as: DSLink
      alias ZaqWeb.Components.DesignSystem.SecretInput, as: DSSecretInput
    end
  end
end

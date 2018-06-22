defmodule Snitch.Data.Schema.OptionValue do
  @moduledoc false
  use Snitch.Data.Schema

  alias Snitch.Data.Schema.OptionType

  @type t :: %__MODULE__{}

  schema "snitch_template_option_values" do
    field(:value, :string)
    timestamps()

    belongs_to(:option_type, OptionType)
  end
end

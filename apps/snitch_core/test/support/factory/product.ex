defmodule Snitch.Factory.Product do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      alias Snitch.Data.Schema

      def product_factory do
        %Schema.Product{
          name: "Firebolt 2015",
          available_on: "",
          deleted_at: nil,
          discontinue_on: nil,
          slug: "firebolt-2015",
          meta_description: "best broom in the wizarding world",
          meta_keywords: "broom,magic,best,firebolt",
          meta_title: "best broom you can get",
          promotionable: true
        }
      end

      def option_type_factory do
        %Schema.OptionType{
          name: "size",
          display_name: "Size"
        }
      end

      def option_value_factory do
        %Schema.OptionValue{
          name: "small",
          display_name: "Small",
          position: 1
        }
      end

      def option_values(%{option_types: option_types} = context) do
      end

      def option_types(context) do
        option_type = insert(:option_type)
        [option_type: option_type]
      end
    end
  end
end

defmodule Snitch.Factory.Product do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      alias Snitch.Data.Schema

      def product_factory do
        %Schema.Product{
          name: sequence(:name, &"Firebolt 201#{&1}"),
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

      def option_values(%{option_type: option_type} = context) do
        count = Map.get(context, :option_value_count, 4)
        option_values = insert_list(count, :option_value, option_type: option_type)
        [option_values: option_values]
      end

      def option_value(%{option_type: option_type} = context) do
        option_value = insert(:option_value, option_type: option_type)
        [option_value: option_value]
      end

      def option_types(context) do
        option_types = insert_list(3, :option_type)
        [option_types: option_types]
      end

      def option_type(context) do
        option_type = insert(:option_type)
        [option_type: option_type]
      end
    end
  end
end

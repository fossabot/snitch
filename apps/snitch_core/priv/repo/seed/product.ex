defmodule Snitch.Seed.Product do
  alias Ecto.DateTime
  alias Snitch.Repo

  alias Snitch.Data.Schema.{
    Product,
    Variant,
    VariantImage,
    StockLocation,
    StockItem,
    ShippingCategory
  }

  @base_path Application.app_dir(:snitch_core, "priv/seed_data/pets_shop")

  def seed do
    product_path = Path.join(@base_path, "products.json")

    with {:ok, file} <- File.read(product_path),
         {:ok, products_json} <- Jason.decode(file) do
      product_list =
        products_json["products"]
        |> Enum.map(&product/1)

      {_, products} = Repo.insert_all(Product, product_list, returning: [:id])

      light = Repo.get_by(ShippingCategory, name: "light")

      variants =
        products_json["products"]
        |> Enum.zip(products)
        |> Enum.map(fn {product_json, product} ->
          product_json["variants"]
          |> Enum.map(fn v -> variant(v, product.id, light.id) end)
        end)
        |> List.flatten()

      {_, variants} = Repo.insert_all(Variant, variants, returning: [:id])

      variant_images =
        products_json["products"]
        |> Enum.flat_map(fn products_json -> products_json["variants"] end)
        |> Enum.zip(variants)
        |> Enum.map(fn {variant_json, variant} ->
          variant_json["images"]
          |> Enum.map(fn url -> variant_image(url, variant.id) end)
        end)
        |> List.flatten()

      Repo.insert_all(VariantImage, variant_images, returning: [:id])

      stock_location = Repo.all(StockLocation)

      stock_items =
        stock_location
        |> Enum.map(fn location ->
          variants
          |> Enum.map(fn variant ->
            %{
              variant_id: variant.id,
              stock_location_id: location.id,
              count_on_hand: 10,
              backorderable: true,
              inserted_at: Ecto.DateTime.utc(),
              updated_at: Ecto.DateTime.utc()
            }
          end)
        end)
        |> List.flatten()

      Repo.insert_all(StockItem, stock_items, returning: [:id])
    end
  end

  def variant_image(url, variant_id) do
    %{
      url: url,
      variant_id: variant_id
    }
  end

  defp product(p) do
    %{
      name: p["name"],
      description: p["description"],
      slug: Slugger.slugify(p["name"]),
      available_on: DateTime.utc(),
      inserted_at: DateTime.utc(),
      updated_at: DateTime.utc()
    }
  end

  def variant(v, product_id, category_id) do
    %{
      sku: v["sku"],
      weight: v["weight"],
      height: v["height"],
      depth: v["depth"],
      selling_price: Money.from_float(v["selling_price"], String.to_atom(v["currency"])),
      cost_price: Money.from_float(v["cost_price"], String.to_atom(v["currency"])),
      position: 0,
      product_id: product_id,
      shipping_category_id: category_id,
      inserted_at: DateTime.utc(),
      updated_at: DateTime.utc()
    }
  end
end

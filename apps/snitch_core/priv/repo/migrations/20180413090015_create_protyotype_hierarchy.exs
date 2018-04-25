defmodule Snitch.Repo.Migrations.CreateProtyotypeHierarchy do
  use Ecto.Migration

  def change do
    create table("snitch_products") do
      add :name, :string, null: false, default: ""
      add :available_on, :utc_datetime
      add :deleted_at, :utc_datetime
      add :discontinue_on, :utc_datetime
      add :slug, :string
      add :meta_description, :string
      add :meta_keywords, :string
      add :meta_title, :string
      add :promotionable, :boolean
      timestamps()
    end

    create table(:snitch_properties) do
      add :name, :string
      add :display_name, :string, null: false
    end

    create table(:snitch_option_types) do
      add :name, :string
      add :display_name, :string

      timestamps()
    end

    create table(:snitch_option_values) do
      add :position, :integer
      add :name, :string
      add :display_name, :string
      add :option_type_id, references(:snitch_option_types, on_delete: :delete_all), null: false
      timestamps()
    end

    create table(:snitch_prototypes) do
      add :name, :string
      timestamps()
    end

    # Intermediate table
    create table(:snitch_option_type_prototypes) do
      add :option_type_id, references(:snitch_option_types)
      add :prototype_id, references(:snitch_prototypes)
    end

    # Intermediate table
    create table(:snitch_property_prototypes) do
      add :property_id, references(:snitch_properties)
      add :prototype_id, references(:snitch_prototypes)
    end

    # Taxons has the same property
    
    alter table(:snitch_properties) do
      timestamps()
    end

    # Indexes
    create index(:snitch_products, [:name, :available_on, :deleted_at, :discontinue_on])
    create unique_index(:snitch_products, [:slug])
    create index(:snitch_properties, [:name])
    create index(:snitch_option_types, [:name])
    create index(:snitch_option_values, [:name, :position, :option_type_id])
  end
end

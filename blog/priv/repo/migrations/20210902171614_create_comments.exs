defmodule Blog.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :text
      add :liked_count, :integer
      add :dislike_count, :integer
      add :smile_count, :integer
      add :post_id, references(:posts, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:comments, [:post_id])
    create index(:comments, [:user_id])
  end
end

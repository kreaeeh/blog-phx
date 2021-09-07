defmodule Blog.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Accounts.User

  schema "comments" do
    field :content, :string
    field :post_id, :id
    field :liked_count, :integer, default: 0
    field :dislike_count, :integer, default: 0
    field :smile_count, :integer, default: 0

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content,:liked_count, :dislike_count, :smile_count, :user_id , :post_id])
    |> validate_required([:content])
  end
end

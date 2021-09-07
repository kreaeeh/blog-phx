defmodule Blog.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Accounts.User
  alias Blog.Comments.Comment
  schema "posts" do
    field :body, :string
    field :title, :string
    belongs_to :user, User
    has_many :comments, Comment
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :user_id])
    |> validate_required([:title, :body])
  end
end

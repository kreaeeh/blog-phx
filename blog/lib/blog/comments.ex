defmodule Blog.Comments do
  @moduledoc """
  The Comments context.
  """

  import Ecto.Query, warn: false
  alias Blog.Repo

  alias Blog.Comments.Comment
  alias Blog.Reactions.Reaction
  require Logger
  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comment{}, ...]

  """
  def list_comments do
    Repo.all(Comment)
  end
  def list_comments_by_post (post_id) do
    query = from(from c in Comment, where: c.post_id == ^post_id, order_by: [desc: c.inserted_at])

    Repo.all(query)
    |> Repo.preload([:user])
  end
  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id) |> Repo.preload(:user)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
    |>broadcast(:comment_created)

  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
    |>broadcast(:comment_updated)
  end

  @doc """
  Deletes a comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
    |>broadcast(:comment_deleted)

  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{data: %Comment{}}

  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end
  def subscribe do
    Phoenix.PubSub.subscribe(Blog.PubSub, "comments")
  end
  defp broadcast({:error, _reason} = error, _event), do: error
  defp broadcast({:ok, comment}, event) do
    Phoenix.PubSub.broadcast(Blog.PubSub, "comments", {event, comment})
    {:ok, comment}
  end

  def inc_likes(%Comment{} = comment) do
    Repo.update_all(Comment, inc: [liked_count: 1])
    comment = get_comment!(comment.id)
    broadcast({:ok, comment}, :comment_updated)
  end
  def inc_smiles(%Comment{} = comment) do
    Repo.update_all(Comment, inc: [smile_count: 1])
    comment = get_comment!(comment.id)
    broadcast({:ok, comment}, :comment_updated)
  end
  def inc_dislikes(%Comment{} = comment) do
    Repo.update_all(Comment, inc: [dislike_count: 1])
    comment = get_comment!(comment.id)
    broadcast({:ok, comment}, :comment_updated)
  end

end

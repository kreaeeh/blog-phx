defmodule BlogWeb.CommentLive.Index do
  use BlogWeb, :live_view

  alias Blog.Comments
  alias Blog.Comments.Comment
  require Logger
  @impl true
  def mount(%{"post_id" => post_id}, session, socket) do
    socket=BlogWeb.LiveHelpers.assign_defaults(session,socket)
    if connected?(socket), do: Comments.subscribe()


      {:ok,
      socket
      |> assign(:comments, list_comments(post_id))
      |> assign(:post_id, post_id)
      |> assign(:current_user_id, socket.assigns.current_user.id),
      temporary_assigns: [comments: []]
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Comment")
    |> assign(:comment, Comments.get_comment!(id))
  end

  defp apply_action(socket, :new, %{"post_id" => post_id}) do
    socket
    |> assign(:page_title, "New Comment")
    |> assign(:comment, %Comment{})
    |> assign(:post_id, post_id)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Comments")
    |> assign(:comment, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    comment = Comments.get_comment!(id)
    {:ok, _} = Comments.delete_comment(comment)

    {:noreply, assign(socket, :comments, list_comments(1))}
  end

  defp list_comments (id) do
    comments = Comments.list_comments_by_post(id)
    Logger.info("comments #{inspect(comments)}")
    comments
  end
  @impl true
  def handle_info({:comment_created, comment}, socket) do
    comment = Comments.get_comment!(comment.id)

    {:noreply, update(socket, :comments, fn comments -> [comment | comments] end)}
  end

  @impl true
  def handle_info({:comment_updated, comment}, socket) do
    {:noreply, update(socket, :comments, fn comments -> [comment | comments] end)}
  end

  @impl true
  def handle_info({:comment_deleted, comment}, socket) do
    {:noreply, update(socket, :comments, fn comments -> [comment | comments] end)}
  end

end

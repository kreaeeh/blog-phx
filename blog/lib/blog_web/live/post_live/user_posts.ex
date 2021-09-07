defmodule BlogWeb.PostLive.UserPosts do
  use BlogWeb, :live_view

  alias Blog.Timeline
  alias Blog.Timeline
  alias Blog.Timeline.Post

  require Logger
  @impl true
  def mount(%{"user_id" => userid}, session, socket) do
    if connected?(socket), do: Timeline.subscribe()

    socket=BlogWeb.LiveHelpers.assign_defaults(session,socket)

    {:ok, assign(socket, :posts, list_posts_by_userid(userid)), temporary_assigns: [posts: []]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, Timeline.get_post!(id))
  end

  defp apply_action(socket, :new, _params) do

    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{})
  end




    defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)


  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Timeline.get_post!(id)
    {:ok, _} = Timeline.delete_post(post)

    {:noreply, assign(socket, :posts, list_posts())}
  end

  @impl true
  def handle_info({:post_created, post}, socket) do
    post = Timeline.get_post!(post.id)

    {:noreply, update(socket, :posts, fn posts -> [post | posts] end)}
  end

  @impl true
  def handle_info({:post_updated, post}, socket) do
    {:noreply, update(socket, :posts, fn posts -> [post | posts] end)}
  end

  @impl true
  def handle_info({:post_deleted, post}, socket) do
    {:noreply, update(socket, :posts, fn posts -> [post | posts] end)}
  end

  defp list_posts do
    Timeline.list_posts()
  end
  defp list_posts_by_userid (id) do
      Timeline.list_posts_by_user(id)
    end
end

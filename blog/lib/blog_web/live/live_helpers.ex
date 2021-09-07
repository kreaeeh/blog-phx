defmodule BlogWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
  alias Blog.Accounts
  alias Blog.Accounts.User
  alias BlogWeb.Router.Helpers, as: Routes
  require Logger
  @doc """
  Renders a component inside the `BlogWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, BlogWeb.PostLive.FormComponent,
        id: @post.id || :new,
        action: @live_action,
        post: @post,
        return_to: Routes.post_index_path(@socket, :index) %>
  """

  def assign_defaults(session, socket) do
    socket =
    Phoenix.LiveView.assign_new(socket, :current_user, fn ->
        find_current_user(session)
      end)
socket
  end

  defp find_current_user(session) do
    with user_token when not is_nil(user_token) <- session["user_token"],
         %User{} = user <- Accounts.get_user_by_session_token(user_token),
         do: user
  end
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, BlogWeb.ModalComponent, modal_opts)
  end
end

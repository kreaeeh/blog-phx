defmodule BlogWeb.CommentLive.CommentComponent do
  use BlogWeb, :live_component
  def render (assigns) do
    ~L"""
        <div  <%= if @comment.__meta__.state == :deleted do %>class="hidden"<% end %>>
           <div class="row">
    <div class="col-md-8">
      <div class="media g-mb-30 media-comment">
        <img class="d-flex g-width-50 g-height-50 rounded-circle g-mt-3 g-mr-15" src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="Image Description">
        <div class="media-body u-shadow-v18 g-bg-secondary g-pa-30">
          <div class="g-mb-15">
            <h5 class="h5 g-color-gray-dark-v1 mb-0"><%= @comment.user.fullname %></h5>
            <span class="g-color-gray-dark-v4 g-font-size-12"><%= @comment.inserted_at %></span>
          </div>

          <p><%= @comment.content %></p>

          <ul class="list-inline d-sm-flex my-0">
            <li class="list-inline-item g-mr-20">
              <a class="u-link-v5 g-color-gray-dark-v4 g-color-primary--hover" href="#" phx-click="like" phx-target="<%= @myself %>">
                <i class="fa fa-thumbs-up g-pos-rel g-top-1 g-mr-3"></i>
                <%= @comment.liked_count %>
              </a>
            </li>
            <li class="list-inline-item g-mr-20">
              <a class="u-link-v5 g-color-gray-dark-v4 g-color-primary--hover" href="#!" phx-click="dislike" phx-target="<%= @myself %>">
                <i class="fa fa-thumbs-down g-pos-rel g-top-1 g-mr-3"></i>
                                <%= @comment.dislike_count %>
              </a>
            </li>
            <li class="list-inline-item ml-auto">
              <a class="u-link-v5 g-color-gray-dark-v4 g-color-primary--hover" href="#!" phx-click="smile" phx-target="<%= @myself %>">
                <i class="fa fa-smile-o g-mr-3"></i>
                <%= @comment.smile_count %>
              </a>
            </li>
            <%= if(@current_user_id == @comment.user.id) do %>

            <li class="list-inline-item ml-auto">
              <a class="u-link-v5 g-color-gray-dark-v4 g-color-primary--hover" href="#!">
                <i class="fa fa-edit g-pos-rel g-top-1 g-mr-3"></i>
                <span><%= live_patch "Edit", to: Routes.comment_index_path(@socket, :edit,@post_id, @comment) %></span>
              </a>
            </li>
            <li class="list-inline-item ml-auto">
              <a class="u-link-v5 g-color-gray-dark-v4 g-color-primary--hover" href="#!">
                <i class="fa fa-trash g-pos-rel g-top-1 g-mr-3"></i>
                <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @comment.id, data: [confirm: "Are you sure?"] %></span>
              </a>
            </li>
            <% end %>
          </ul>
        </div>
      </div>
    </div>


    </div>

    """
  end

def handle_event("like", _, socket) do
  Blog.Comments.inc_likes(socket.assigns.comment)
  {:noreply, socket}

  end
  def handle_event("dislike",_, socket) do
    Blog.Comments.inc_dislikes(socket.assigns.comment)
    {:noreply, socket}

  end
  def handle_event("smile", _, socket) do
    Blog.Comments.inc_smiles(socket.assigns.comment)
    {:noreply, socket}
  end
end
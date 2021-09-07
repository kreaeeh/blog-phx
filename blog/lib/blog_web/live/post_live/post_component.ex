defmodule BlogWeb.PostLive.PostComponent do
use BlogWeb, :live_component
def render (assigns) do
  ~L"""
    <div  <%= if @post.__meta__.state == :deleted do %>class="hidden"<% end %>>
     <div id="post-<%= @post.id %>" class="post" >
      <div class="container">
        <div class="row">
          <div class="col-md-8">
            <div class="media g-mb-30 media-comment">
                <div class="media-body u-shadow-v18 g-bg-secondary g-pa-30">

    <div class="span8">
      <div class="row">
        <div class="span8">
          <h4><strong><%= live_patch @post.title, to: Routes.post_show_path(@socket, :show, @post.id) %></strong></h4>
        </div>

      </div>
      <div class="row">
        <div class="span2">
        <%=@post.body%>
        </div>
        <div class="span6">
          <p>

          </p>
          <p><%= live_patch "read more", to: Routes.post_show_path(@socket, :show, @post.id) %></strong></p>
        </div>
      </div>
      <div class="row">
        <div class="span8">
          <p></p>
          <p>
            <i class="icon-comment"></i><%= live_patch @post.user.fullname, to: Routes.post_user_posts_path(@socket, :index, @post.user.id) %>
            | <i class="icon-calendar"><%=  @post.updated_at %></i>
              | <i class="icon-comment"></i><%= live_patch "Comments", to: Routes.comment_index_path(@socket, :index, @post.id) %>
              <%= if assigns[:current_user_id] do %>
              <%= if(@current_user_id == @post.user.id) do %>
            | <i class="icon-comment"></i><%= live_patch "Edit Blog", to: Routes.post_index_path(@socket, :edit, @post.id) %>
            | <i class="icon-comment"></i>  <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] %></span>
              <% end %>
              <% end %>

                </p>
        </div>
      </div>
    </div>

                </div>

            </div>

          </div>

        </div>
      </div>
   </div>

</div>

"""
end



end
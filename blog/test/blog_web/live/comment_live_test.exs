defmodule BlogWeb.CommentLiveTest do
  use BlogWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Blog.Comments

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  defp fixture(:comment) do
    {:ok, comment} = Comments.create_comment(@create_attrs)
    comment
  end

  defp create_comment(_) do
    comment = fixture(:comment)
    %{comment: comment}
  end

  describe "Index" do
    setup [:create_comment]

    test "lists all comments", %{conn: conn, comment: comment} do
      {:ok, _index_live, html} = live(conn, Routes.comment_index_path(conn, :index))

      assert html =~ "Listing Comments"
      assert html =~ comment.content
    end

    test "saves new comment", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.comment_index_path(conn, :index))

      assert index_live |> element("a", "New Comment") |> render_click() =~
               "New Comment"

      assert_patch(index_live, Routes.comment_index_path(conn, :new))

      assert index_live
             |> form("#comment-form", comment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#comment-form", comment: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.comment_index_path(conn, :index))

      assert html =~ "Comment created successfully"
      assert html =~ "some content"
    end

    test "updates comment in listing", %{conn: conn, comment: comment} do
      {:ok, index_live, _html} = live(conn, Routes.comment_index_path(conn, :index))

      assert index_live |> element("#comment-#{comment.id} a", "Edit") |> render_click() =~
               "Edit Comment"

      assert_patch(index_live, Routes.comment_index_path(conn, :edit, comment))

      assert index_live
             |> form("#comment-form", comment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#comment-form", comment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.comment_index_path(conn, :index))

      assert html =~ "Comment updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes comment in listing", %{conn: conn, comment: comment} do
      {:ok, index_live, _html} = live(conn, Routes.comment_index_path(conn, :index))

      assert index_live |> element("#comment-#{comment.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#comment-#{comment.id}")
    end
  end

  describe "Show" do
    setup [:create_comment]

    test "displays comment", %{conn: conn, comment: comment} do
      {:ok, _show_live, html} = live(conn, Routes.comment_show_path(conn, :show, comment))

      assert html =~ "Show Comment"
      assert html =~ comment.content
    end

    test "updates comment within modal", %{conn: conn, comment: comment} do
      {:ok, show_live, _html} = live(conn, Routes.comment_show_path(conn, :show, comment))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Comment"

      assert_patch(show_live, Routes.comment_show_path(conn, :edit, comment))

      assert show_live
             |> form("#comment-form", comment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#comment-form", comment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.comment_show_path(conn, :show, comment))

      assert html =~ "Comment updated successfully"
      assert html =~ "some updated content"
    end
  end
end

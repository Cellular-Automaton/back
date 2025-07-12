defmodule BackWeb.Router do
  @moduledoc """
  Hosts all routes
  """
  use BackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Guardian.Plug.Pipeline,
      error_handler: Back.Users.ErrorHandler,
      module: Back.Users.Guardian

    plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
    plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end

  scope "/api", BackWeb do
    @doc elem(File.read("./priv/static/routes.md"), 1)
    pipe_through :api

    post "/user", UserController, :create
    post "/user/pictures", UserController, :create_pic
    post "/login", AuthController, :login

    # automaton
    get "/automaton", AutomatonController, :index
    get "/automaton/images", AutomatonController, :index_img
    get "/automaton/images/:id", AutomatonController, :show_img
    get "/automaton/recent/:nb", AutomatonController, :get_recents
    get "/automaton_comment/automaton/:id", AutomatonCommentsController, :get_by_automaton

    # user
    get "/user/pictures", UserController, :index_pic
    get "/user/pictures/:user_id", UserController, :show_pic

    # token check
    scope "/" do
      pipe_through :auth
      resources "/user", UserController, except: [:new, :edit, :create]
      get "/user/favorite/:user_id", FavoriteController, :get_by_user

      resources "/post", PostController, except: [:new, :edit]
      resources "/automaton", AutomatonController, except: [:new, :edit, :index]
      post "/automaton/image", AutomatonController, :create_image
      resources "/comment", CommentController, except: [:new, :edit]
      resources "/blocked", BlockedController, except: [:new, :edit]
      resources "/favorite", FavoriteController, except: [:new, :edit]
      resources "/posts_actions", PostActionsController, except: [:new, :edit]
      resources "/automaton_comment", AutomatonCommentsController, except: [:new, :edit]
      resources "/tag", TagController, except: [:new, :edit]
      resources "/automaton_tag", AutomatonTagController, except: [:new, :edit]
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:back, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BackWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

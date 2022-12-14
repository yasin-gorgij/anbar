defmodule AnbarWeb.Router do
  use AnbarWeb, :router

  import AnbarWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AnbarWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers, %{"content-security-policy" => "default-src 'self'"}
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AnbarWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", AnbarWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: AnbarWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", AnbarWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
  end

  scope "/", AnbarWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update

    get "/inventories", InventoryController, :index
    get "/inventories/:id/edit", InventoryController, :edit
    get "/inventories/new", InventoryController, :new
    get "/inventories/:id", InventoryController, :show
    post "/inventories", InventoryController, :create
    put "/inventories/:id", InventoryController, :update
    delete "/inventories/:id", InventoryController, :delete

    get "/inventories/:inventory_id/items/:id/edit", ItemController, :edit
    get "/inventories/:inventory_id/items/new", ItemController, :new
    post "/inventories/:inventory_id/items", ItemController, :create
    put "/inventories/:inventory_id/items/:id", ItemController, :update
    delete "/inventories/:inventory_id/items/:id", ItemController, :delete
  end

  scope "/", AnbarWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
  end
end

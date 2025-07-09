```
  POST    /api/user                    BackWeb.UserController :create
  POST    /api/user/pictures           BackWeb.UserController :create_pic
  POST    /api/login                   BackWeb.AuthController :login
  GET     /api/automaton               BackWeb.AutomatonController :index
  GET     /api/automaton/images        BackWeb.AutomatonController :index_img
  GET     /api/automaton/images/:id    BackWeb.AutomatonController :show_img
  GET     /api/user/pictures           BackWeb.UserController :index_pic
  GET     /api/user/pictures/:user_id  BackWeb.UserController :show_pic
  GET     /api/user                    BackWeb.UserController :index
  GET     /api/user/:id                BackWeb.UserController :show
  PATCH   /api/user/:id                BackWeb.UserController :update
  PUT     /api/user/:id                BackWeb.UserController :update
  DELETE  /api/user/:id                BackWeb.UserController :delete
  GET     /api/post                    BackWeb.PostController :index
  GET     /api/post/:id                BackWeb.PostController :show
  POST    /api/post                    BackWeb.PostController :create
  PATCH   /api/post/:id                BackWeb.PostController :update
  PUT     /api/post/:id                BackWeb.PostController :update
  DELETE  /api/post/:id                BackWeb.PostController :delete
  GET     /api/automaton/:id           BackWeb.AutomatonController :show
  POST    /api/automaton               BackWeb.AutomatonController :create
  PATCH   /api/automaton/:id           BackWeb.AutomatonController :update
  PUT     /api/automaton/:id           BackWeb.AutomatonController :update
  DELETE  /api/automaton/:id           BackWeb.AutomatonController :delete
  POST    /api/automaton/image         BackWeb.AutomatonController :create_image
  GET     /api/comment                 BackWeb.CommentController :index
  GET     /api/comment/:id             BackWeb.CommentController :show
  POST    /api/comment                 BackWeb.CommentController :create
  PATCH   /api/comment/:id             BackWeb.CommentController :update
  PUT     /api/comment/:id             BackWeb.CommentController :update
  DELETE  /api/comment/:id             BackWeb.CommentController :delete
  GET     /api/blocked                 BackWeb.BlockedController :index
  GET     /api/blocked/:id             BackWeb.BlockedController :show
  POST    /api/blocked                 BackWeb.BlockedController :create
  PATCH   /api/blocked/:id             BackWeb.BlockedController :update
  PUT     /api/blocked/:id             BackWeb.BlockedController :update
  DELETE  /api/blocked/:id             BackWeb.BlockedController :delete
  GET     /api/favorite                BackWeb.FavoriteController :index
  GET     /api/favorite/:id            BackWeb.FavoriteController :show
  POST    /api/favorite                BackWeb.FavoriteController :create
  PATCH   /api/favorite/:id            BackWeb.FavoriteController :update
  PUT     /api/favorite/:id            BackWeb.FavoriteController :update
  DELETE  /api/favorite/:id            BackWeb.FavoriteController :delete
  GET     /api/posts_actions           BackWeb.PostActionsController :index
  GET     /api/posts_actions/:id       BackWeb.PostActionsController :show
  POST    /api/posts_actions           BackWeb.PostActionsController :create
  PATCH   /api/posts_actions/:id       BackWeb.PostActionsController :update
  PUT     /api/posts_actions/:id       BackWeb.PostActionsController :update
  DELETE  /api/posts_actions/:id       BackWeb.PostActionsController :delete
  GET     /api/automaton_comment       BackWeb.AutomatonCommentsController :index
  GET     /api/automaton_comment/:id   BackWeb.AutomatonCommentsController :show
  POST    /api/automaton_comment       BackWeb.AutomatonCommentsController :create
  PATCH   /api/automaton_comment/:id   BackWeb.AutomatonCommentsController :update
  PUT     /api/automaton_comment/:id   BackWeb.AutomatonCommentsController :update
  DELETE  /api/automaton_comment/:id   BackWeb.AutomatonCommentsController :delete
  GET     /dev/dashboard/css-:md5      Phoenix.LiveDashboard.Assets :css
  GET     /dev/dashboard/js-:md5       Phoenix.LiveDashboard.Assets :js
  GET     /dev/dashboard               Phoenix.LiveDashboard.PageLive :home
  GET     /dev/dashboard/:page         Phoenix.LiveDashboard.PageLive :page
  GET     /dev/dashboard/:node/:page   Phoenix.LiveDashboard.PageLive :page
  *       /dev/mailbox                 Plug.Swoosh.MailboxPreview []
  WS      /live/websocket              Phoenix.LiveView.Socket
  GET     /live/longpoll               Phoenix.LiveView.Socket
  POST    /live/longpoll               Phoenix.LiveView.Socket

```
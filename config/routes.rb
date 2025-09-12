Rails.application.routes.draw do
  # Routes for the Message resource:

  # CREATE
  post("/insert_message", { :controller => "messages", :action => "create" })

  # READ
  get("/messages", { :controller => "messages", :action => "index" })

  get("/messages/:path_id", { :controller => "messages", :action => "show" })

  # UPDATE

  post("/modify_message/:path_id", { :controller => "messages", :action => "update" })

  # DELETE
  get("/delete_message/:path_id", { :controller => "messages", :action => "destroy" })

  #------------------------------

  # Routes for the Quiz resource:

  # CREATE
  post("/insert_quiz", { :controller => "quizzes", :action => "create" })

  # READ
  get("/quizzes", { :controller => "quizzes", :action => "index" })

  get("/quizzes/:path_id", { :controller => "quizzes", :action => "show" })

  # UPDATE

  post("/modify_quiz/:path_id", { :controller => "quizzes", :action => "update" })

  # DELETE
  get("/delete_quiz/:path_id", { :controller => "quizzes", :action => "destroy" })

  #------------------------------

  devise_for :users
  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get("/your_first_screen", { :controller => "pages", :action => "first" })
end

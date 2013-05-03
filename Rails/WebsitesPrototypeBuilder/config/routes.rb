WebsitesPrototypeBuilder::Application.routes.draw do
  get "tests/test_scan"

  post 'projects/savePage'
  get 'projects/savePage'
  get 'projects/createPage'
  get 'projects/deletePage'
  get 'projects/showPage'
  get 'projects/design'

  # set devise for Designer, and set the registerations controller to the custom one
  devise_for :designers, :controllers => { :registrations => "registrations" }

  get 'projects/destroy'
  get "projects/:project_id/tasks/:task_id/steps/:step_id/reviewers/:reviewer_id" =>'tasks#task_reviewer'
  post 'steps/update'

  resources :projects do
    resources :tasks do
      resources :steps
    end
  end

  resources :projects do
    resources :pages  
  end

  resources :statistics

  resources :projects do
    resources :tasks do
      resources :steps
      resources :task_results
    end
  end

resources :logs
post 'logs/new'


post 'reviewers/:reviewer_id/reviewer_infos/new' => "reviewer_infos#new"
resources :reviewers do
  resources :reviewer_infos
end

 post 'cardsorts/invite_reviewer'
 get 'cardsorts/invitations/:cardsort_id' => 'cardsorts#invitations'
 post 'cardsorts/:cardsort_id/reviewer_create_group' => 'cardsorts#reviewer_create_group'
 post 'cardsorts/submit/:cardsort_id/reviewer/:reviewer_id' => 'cardsorts#submit'
 get 'cardsorts/review/:cardsort_id/reviewer/:reviewer_id' => 'cardsorts#review'
 post 'cardsorts/:cardsort_id/delete_card/:card_id' => 'cardsorts#delete_card'
 post 'cardsorts/:cardsort_id/delete_group/:group_id' => 'cardsorts#delete_group'
 post 'cardsorts/:cardsort_id/create_card' => 'cardsorts#create_card'
 post 'cardsorts/:cardsort_id/create_group' => 'cardsorts#create_group'
 post 'cardsorts/create_cardsort'
 get 'cardsorts/show/:cardsort_id' => 'cardsorts#show'
 get 'cardsorts/new'
 get 'cardsorts/edit'  
 get 'cardsorts/create'


 get 'cardsorts/create_card'
 get 'cardsorts/create_group'
 get 'cardsorts/reviewer_invitation/:cardsort_id' => "cardsorts#reviewer_invitation"
 
  #at start up page goes to the home controller and the index action

  root to: "projects#index"

  get "comments/create"
  get "comments/destroy"
  get "questions/create"
  get "questions/destroy"
  get "answers/create"
  get "answers/destroy"
  get "pages/reviewer"
  get "pages/designer"
  get "projects/index"
  get "projects/savePage/" => "projects#savePage" #, :as => :page_save 
  get "projects/deletePage/" => "projects#deletePage" #, :as => :page_save 
  get "projects/createPage/" => "projects#createPage" #, :as => :page_save 
  get "questionnaires/answer_show"
  get "questionnaires/index"
  post "projects/upload_media"

  resources :projects
 
  resources :questionnaires do

  get "pages/download"
  get "pages/download_project"
  get "questionnaires/answer_show"
  get "questionnaires/index"
  get "pages/flowchart"

  get "answer_questionnaires/create"

   resources :questionnaires do

    resources :qquestions do
      resources :choice_qquestions
      resources :answer_questionnaires
      end
    end
  end

  resources :pages do
    resources :comments
    resources :questions do
      resources :answers
    end
  end
 
  get "/log/:id" => 'task_results#index'
  get "/tasks/edit_steps/:id" => "tasks#edit_steps", :as => :edit_steps
  get "/tasks/new_step/" => "tasks#new_step",:as => :new_step
  get "/tasks/delete_step/" => "tasks#delete_step", :as => :delete_step
  get "tasks/invite/:id" => "tasks#invite"
  
  get "/taketask/:task_id/:reviewer_id" => 'tasks#makesure'
  match "/task" => 'task#fill_task' #Try to change this, not regular way of having routes + will match any incorrect url in the task path

  # get 'projects/design/:project_id' => 'projects#design' 
  
  post "tasks/invite_user/:id" => "tasks#invite_user"

  get "/log/:id" => 'task_results#index'
  get 'projects/design/:project_id' => 'projects#design'
  get '/projects/:project_id/tasks/:task_id/result/:result_id' => 'tasks#log'
end

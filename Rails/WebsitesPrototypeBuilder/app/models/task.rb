  ##
  # each instance of this model represents a task that belongs to one project
  #* *Attributes*    :
  #   -+name+ -> name of the task (string)
  #   -+description+ -> description of task (text)
  #* *Relations*    :
  #   -belongs to one project 
  #   -belongs to one page 
  #   -has many task results 
  #   -has a many to many relationship with reviewers
class Task<ActiveRecord::Base

  attr_accessible :description, :name, :page_id, :time_limit, :requires_reviewer_info, :project_id, :final_step


  belongs_to :project
  belongs_to :page
  has_many :steps
  has_many :task_results
  has_and_belongs_to_many :reviewers

  validates :name, :presence => true
  validates :project, :presence => true

  ##
  # send a task invitation to specified email
  # create the reviewer if not already existant
  # * *Args* :
  # - +email+ -> the current page
  # - +msg+ -> custom message for the email
  # - +url+ -> url to take the invitation
  # * *Returns* :
  # - void
  #
  def send_invitation(email, msg, url)
    @reviewer = Reviewer.find_by_email(email)
    if @reviewer == nil
      @reviewer = self.reviewers.create(:email => email) 
    end
    ReviewerInviter.task_invitation(email, msg, url).deliver()
  end

 ##Author :Sarah
  # Updates the step_id,task_result and creates a new step_answer
  # * *Args* :
  # - +step+ -> the current step
  # - +task_result+ -> the current task_result
  # - +previous_step+ -> the previous step
  # - +step_answer+ -> the current step_answer
  # * *Returns* :
  # - void
  #
  def update_taskResults(params,task_result_id)
    if Integer(params[:change_id]) <= self.steps.last.id
      @step=self.steps.find(params[:change_id])

      @task_result= self.task_results.find(task_result_id)
      @task_result.clicks= params[:change_clicks]
      @task_result.time=params[:total_time_taken]
      @task_result.save

    else
      @task_result=self.task_results.find(task_result_id)
      @task_result.success='true'
      @task_result.save  
    end 
    @previous_step = self.steps.find(Integer(params[:change_id])-1)
    @step_answer=@previous_step.step_answers.new
    @step_answer.successful= params[:change_success]
    @step_answer.time_from_start= params[:start_time]
    @step_answer.task_result_id=task_result_id    
    @step_answer.reviewer_id=@task_result.reviewer_id
    puts "aaaaa"
    @step_answer.save 

    hash = Hash.new
    hash = {:step => @step, :page => @page, :task_result => @task_result}
  end
end


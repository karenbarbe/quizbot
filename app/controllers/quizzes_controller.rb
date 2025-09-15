class QuizzesController < ApplicationController
  def index
    matching_quizzes = current_user.quizzes

    @list_of_quizzes = matching_quizzes.order({ :created_at => :desc })

    render({ :template => "quiz_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_quizzes = Quiz.where({ :id => the_id })

    @the_quiz = matching_quizzes.at(0)

    render({ :template => "quiz_templates/show" })
  end

  def create
    the_quiz = Quiz.new
    the_quiz.topic = params.fetch("query_topic")
    the_quiz.user_id = current_user.id

    if the_quiz.valid?
      the_quiz.save

      chat = AI::Chat.new
      chat.system("You are an expert in #{the_quiz.topic}. Ask the user three questions to assess their proficiency in that topic. If they answer correctly, ask a harder question next. If they answer incorrectly, ask an easier question next. At the end, assign a score between 0 and 10.")
      chat.user("Please assess my proficiency in #{the_quiz.topic}")
      @ai_response = chat.generate!

      message = Message.new
      message.quiz_id = the_quiz.id
      message.content = @ai_response
      message.role = "assistant"
      message.prev_model_response_id = chat.previous_response_id
      message.save

      redirect_to("/quizzes/#{the_quiz.id}", { :notice => "Quiz created successfully." })
    else
      redirect_to("/quizzes", { :alert => the_quiz.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_quiz = Quiz.where({ :id => the_id }).at(0)

    the_quiz.topic = params.fetch("query_topic")
    the_quiz.user_id = params.fetch("query_user_id")
    the_quiz.score = params.fetch("query_score")

    if the_quiz.valid?
      the_quiz.save
      redirect_to("/quizzes/#{the_quiz.id}", { :notice => "Quiz updated successfully." } )
    else
      redirect_to("/quizzes/#{the_quiz.id}", { :alert => the_quiz.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_quiz = Quiz.where({ :id => the_id }).at(0)

    the_quiz.destroy

    redirect_to("/quizzes", { :notice => "Quiz deleted successfully." } )
  end
end

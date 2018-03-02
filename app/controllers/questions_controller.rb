class QuestionsController < ApplicationController
    def new
        @question = Question.new
        @subjects = Subject.all
    end
    
    def create
    end
end

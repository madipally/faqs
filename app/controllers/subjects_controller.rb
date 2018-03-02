class SubjectsController < ApplicationController
  
    def new
      @subject = Subject.new
    end
    
    def create
      @subject = Subject.new(subject_params)
      if @subject.save
        flash[:success] = 'Subject created succefully'
        redirect_to root_path
      else
        render 'new'
      end
    end
    
    private
    def subject_params
      params.require(:subject).permit(:name,:description)
    end
end

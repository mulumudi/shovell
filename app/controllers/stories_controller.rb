class StoriesController < ApplicationController
  
  before_filter :login_required, :only => :new
  def index
@stories = Story.all
end
def new 

@story = Story.new 
end
def create
@story = Story.new(params[:story])
@story.user = @current_user
	respond_to do |format|
      if @story.save
	  flash[:notice] = "Story submission succeeded"
	   
        format.html { redirect_to( :action => 'index' ) }  
		
	
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
end
def show
@stories = Story.where(["permalink = ?", params[:permalink]]) 
end

def vote
 
@story = Story.find(params[:id])
 
 @story.votes.create
 end

end
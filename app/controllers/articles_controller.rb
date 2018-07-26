class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :destroy, :edit, :update]

def new
  @article = Article.new
end

def create
  @article = Article.new(article_params)
  if @article.save
    flash[:notice] = "Saved"
    redirect_to article_path(@article)
  else
    flash[:notice] = "Try again"
    render 'new'
  end
  
end

def index
  @articles = Article.all
end

def show
end

def destroy
  @article.destroy
  flash[:notice] = "Deleted"
  redirect_to articles_path
end

def edit
end

def update
  if @article.update(article_params)
    flash[:notice] = "Updated"
    redirect_to article_path(@article)
  else
    render 'edit'
  end
end


private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params 
    params.require(:article).permit(:title, :description)
  end

end
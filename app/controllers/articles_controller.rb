class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :destroy, :edit, :update]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

def new
  @article = Article.new
end

def create
  @article = Article.new(article_params)
  @article.user = current_user
  if @article.save
    flash[:success] = "Saved"
    redirect_to article_path(@article)
  else
    flash[:notice] = "Try again"
    render 'new'
  end
  
end

def index
  @articles = Article.paginate(page: params[:page], per_page: 2)
end

def show
end

def destroy
  @article.destroy
  flash[:danger] = "Deleted"
  redirect_to articles_path
end

def edit
end

def update
  if @article.update(article_params)
    flash[:success] = "Updated"
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

  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to root_path
    else
      
    end
  end

end
#articles routes
#
#       Prefix Verb   URI Pattern                  Controller#Action
#     articles GET    /articles(.:format)          articles#index
#              POST   /articles(.:format)          articles#create
#  new_article GET    /articles/new(.:format)      articles#new
# edit_article GET    /articles/:id/edit(.:format) articles#edit
#      article GET    /articles/:id(.:format)      articles#show
#              PATCH  /articles/:id(.:format)      articles#update
#              PUT    /articles/:id(.:format)      articles#update
#              DELETE /articles/:id(.:format)      articles#destroy

class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end
  
  def new
  end
  
  def create
    puts '>>> article_params:', article_params
    @article = Article.new(article_params)
    
    puts '>>> article:', @article
    @article.save
    redirect_to @article
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
  
end

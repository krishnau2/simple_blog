class TagsController < ApplicationController

  def show
    @searched_tag = params[:id]
    @tags = Tag.where("name = ?",@searched_tag)
  end

  def index
    @tag_list = Tag.select("DISTINCT(name)")
  end
end

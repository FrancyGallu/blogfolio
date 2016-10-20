class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.not_deleted.order("created_at DESC").page params[:page]
    @tags = Tag.not_deleted
  end

  # GET /posts/archive
  def archive
    @grouped_posts = group_post(Post.not_deleted.order("created_at DESC"))
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.tags = Tag.where(id: check_tags(params[:post][:tags]))

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        @post.tags = Tag.where(id: check_tags(params[:post][:tags]))
        @post.save!
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end

    # Verifies if there are new tags in the submitted parameters.
    # If so, creates the new tags and correctly formats the tag_list with the new tags
    def check_tags(tag_list)
      tag_list.reject!(&:empty?)

      tag_list.each_with_index do |tag_value, index|
        if tag_value.to_i == 0 # If it's a word, not an id
          new_tag_id = Tag.create(name: tag_value).id
          tag_list[index] = new_tag_id.to_s
        end
      end
    end

    # Groups all posts in a structure like:
    # { year => { "month" => { posts } } }
    def group_post(posts)
      grouped_posts = {}
      all_years = posts.map(&:creation_year).uniq

      all_years.each do |year|
        grouped_posts[year] = Post.by_creation_year(year).group_by { |post| post.created_at.strftime("%B") }
      end

      return grouped_posts
    end
end

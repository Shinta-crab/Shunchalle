class FoodsController < ApplicationController
  before_action :set_food, only: %i[ show edit update destroy ]

  # GET /foods/new
  def new; end

  # POST /foods/search 旬の食材を検索
  def search
    input_date = Date.parse(params[:date])
    week_number = input_date.cweek #cweekはISO形式の週番号(1~53)

    session[:search_week] = week_number # 検索された週をセッションに保存

    @foods = Food.where("(start_week <= end_week AND start_week <= :week AND :week <= end_week)
      OR (start_week > end_week AND (:week >= start_week OR :week <= end_week))", week: week_number)
    
    # 検索結果のIDをデータベースに一時保存
    search_session = SearchSession.create!(foods_ids: @foods.pluck(:id).to_json)
    session[:search_session_id] = search_session.id

    # 新しいルートにリダイレクト
    redirect_to results_path
  end

  # GET /foods or /foods.json
  def results
    # セッションに保存したIDを使ってデータベースから検索結果を取得
    search_session = SearchSession.find_by(id: session[:search_session_id])
    search_week = session[:search_week]
    
    # セッション保存した検索結果があり、かつ検索した週が存在する場合
    if search_session && search_week
      food_ids = JSON.parse(search_session.foods_ids)
      @foods = Food.where(id: food_ids).includes(:recipes)

      # 珍旬食材を検索＋レシピデータ取得
      # is_rareがtrueで、かつrecommend_weekが検索された週と一致する食材を1つ取得
      @rare_food = @foods.find_by(is_rare: true, recommend_week: search_week)
      @rare_food_recipe = @rare_food.recipes.first if @rare_food

      # 一度表示したらデータベースから一時データを削除
      search_session.destroy
    else
      @foods = []
    end
      
    # セッションからIDを削除
    session.delete(:search_session_id)
    session.delete(:search_week) # セッションから週を削除
  end

  # GET /foods or /foods.json
  def index; end

  # GET /foods/1 or /foods/1.json
  def show
  end

  # GET /foods/1/edit
  def edit
  end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: "Food was successfully created." }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to @food, notice: "Food was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food.destroy!

    respond_to do |format|
      format.html { redirect_to foods_path, notice: "Food was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def food_params
      params.require(:food).permit(:food_name, :category_id, :start_week, :end_week, :most_product_week, :is_rare, :image, :recommend_week)
    end
end

class FoodsController < ApplicationController
  before_action :set_food, only: %i[ show edit update destroy ]

  # GET /foods/new
  def new; end

  # POST /foods/search 旬の食材を検索
  def search
    input_date = Date.parse(params[:date])
    week_number = input_date.cweek #cweekはISO形式の週番号(1~53)
    @foods = Food.where("start_week <= ? AND end_week >= ?", week_number, week_number)
    # 検索結果をセッションに一時的に保存する
    session[:foods] = @foods.to_a # to_aはActiveRecord::Relationを配列に変換します

    # 新しいルートにリダイレクト
    redirect_to results_path
  end

  # GET /foods or /foods.json
  def results
    # searchアクションで保存した検索結果を取得
    @foods = Food.where(id: session[:foods].map(&:id))
    # セッションからデータを削除する
    session.delete(:foods)

    # このアクションに対応するビューが表示される
    # app/views/foods/results.html.erb
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

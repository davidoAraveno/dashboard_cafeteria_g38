class DrinksController < ApplicationController
  before_action :set_drink, only: %i[ show edit update destroy ]

  # GET /drinks or /drinks.json
  def index
    @drinks = Drink.all
  end

  def dashboard
    #@sales_total = Sale.where('created_at between ? and ?', Date.today, 1.week.ago).group_by_day(:created_at).order("day asc").sum(:total)
    @sales_total = Sale.where("created_at BETWEEN ? AND ?", 12.months.ago, Date.today).order("created_at asc").pluck(:created_at, :total)
    @hash = {}

    @sales_total.each do |sale|
      @date = sale[0].strftime("%Y-%m")
      if @hash[@date]
        @hash[@date] += sale[1]
      else
        @hash[@date] = sale[1]
      end
    end
    
    #@sales_at_last_year = Sale.all.sales_at_last_year.order(:created_at)
  end

  # GET /drinks/1 or /drinks/1.json
  def show
  end

  # GET /drinks/new
  def new
    @drink = Drink.new
  end

  # GET /drinks/1/edit
  def edit
  end

  # POST /drinks or /drinks.json
  def create
    @drink = Drink.new(drink_params)

    respond_to do |format|
      if @drink.save
        format.html { redirect_to @drink, notice: "Drink was successfully created." }
        format.json { render :show, status: :created, location: @drink }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @drink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drinks/1 or /drinks/1.json
  def update
    respond_to do |format|
      if @drink.update(drink_params)
        format.html { redirect_to @drink, notice: "Drink was successfully updated." }
        format.json { render :show, status: :ok, location: @drink }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @drink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drinks/1 or /drinks/1.json
  def destroy
    @drink.destroy
    respond_to do |format|
      format.html { redirect_to drinks_url, notice: "Drink was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drink
      @drink = Drink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def drink_params
      params.require(:drink).permit(:price, :origin, :blend_name)
    end
end

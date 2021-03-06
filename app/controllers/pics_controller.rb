class PicsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_pic, only: [:show, :edit, :update, :destroy]

    # GET /pics
    # GET /pics.json
    def index
        @pics = current_user.pics
        @total_size = 0
        @pics.each do |pic|
            @total_size+=pic.image_file_size
        end
        @total_size /= 1000000.0
        @total_count = @pics.count
    end

    # GET /pics/1
    # GET /pics/1.json
    def show
        authorize! :read, @pic
        bitly = Shortly::Clients::Bitly
        bitly.apiKey  = ENV['BITLY_API_KEY_ID']
        bitly.login   = ENV['BITLY_LOGIN_USERNAME']
        @url = bitly.shorten(@pic.image.url(:original)).url
    end

    # GET /pics/new
    def new
        @pic = Pic.new
    end

    # GET /pics/1/edit
    def edit
        authorize! :update, @pic
    end

    # POST /pics
    # POST /pics.json
    def create
        @pic = current_user.pics.new(pic_params)

        respond_to do |format|
            if @pic.save
                format.html { redirect_to @pic, notice: 'Pic was successfully created.' }
                format.json { render :show, status: :created, location: @pic }
            else
                format.html { render :new }
                format.json { render json: @pic.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /pics/1
    # PATCH/PUT /pics/1.json
    def update
        authorize! :update, @pic
        respond_to do |format|
            if @pic.update(pic_params)
                format.html { redirect_to @pic, notice: 'Pic was successfully updated.' }
                format.json { render :show, status: :ok, location: @pic }
            else
                format.html { render :edit }
                format.json { render json: @pic.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /pics/1
    # DELETE /pics/1.json
    def destroy
        authorize! :destroy, @pic
        @pic.destroy
        respond_to do |format|
            format.html { redirect_to pics_url, notice: 'Pic was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_pic
        @pic = Pic.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pic_params
        params.require(:pic).permit(:title, :details, :image)
    end
end

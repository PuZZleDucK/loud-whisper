class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show edit update destroy ]

  @@audio_sample_count = 10
  @@current_audio_sample = 0
  @@audio_data_a = []
  # @@audio_data_b = []

  # GET /chats or /chats.json
  def index
    @chats = Chat.all
  end

  # GET /chats/1 or /chats/1.json
  def show
  end

  # GET /chats/new
  def new
    @chat = Chat.new
  end

  # GET /chats/1/edit
  def edit
    # puts "data from js call: #{params[:data]}"
    data = params[:data].split(",")
    # puts "data from js call: #{data[1..5]}  - length: #{data.length}"
    # cache ~10 samples of audio data before writing to file and calling background job
    if @@current_audio_sample < @@audio_sample_count
      @@audio_data_a << data
      @@current_audio_sample += 1
      # puts "\n\n\n\n\n\n\n\n\nadding #{data.length} samples to data (#{@@audio_data_a.length} accumulated samples)\n\n\n\n\n\n\n"
    else
      puts "\n\n\n\n\n\n\n\n\nwriting file and creating job (#{@@audio_data_a.flatten.length} samples)\n\n\n\n\n\n\n"
      # write file and create job
      audio_file_path = Rails.root.join('storage', 'audio-test.wav')
      format = WavFile::Format.new(nil)
      format.channel = 1
      format.hz = 48000
      format.bytePerSec = 48000
      format.blockSize = 1
      format.bitPerSample = 16
      File.open(audio_file_path, 'wb') do |f|
        # WavFile::write(f, format, @@audio_data_a.flatten)


        # f.write @@audio_data_a.flatten
        # output_bytes = IOUtils.toByteArray(@@audio_data_a.flatten)
        # output_format = AudioFileFormat.Type.WAVE # AudioFormat(48000,16,2,true,true)
        # AudioSystem.write(output_bytes, output_format,output_bytes.length/4)

      end
      @@audio_data_a = []
      @@current_audio_sample = 0
    end



    # call wisper with file param
    # result = `whisper #{audio_file_path} --model medium`
    # puts "result: #{result}"

  end

  # POST /chats or /chats.json
  def create
    @chat = Chat.new(chat_params)

    respond_to do |format|
      if @chat.save
        format.html { redirect_to chat_url(@chat), notice: "Chat was successfully created." }
        format.json { render :show, status: :created, location: @chat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chats/1 or /chats/1.json
  def update
    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to chat_url(@chat), notice: "Chat was successfully updated." }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1 or /chats/1.json
  def destroy
    @chat.destroy!

    respond_to do |format|
      format.html { redirect_to chats_url, notice: "Chat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.permit(:chat, :data)
      # binding.pry
      # params.fetch(:chat, :data, {})
    end
end

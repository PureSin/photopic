class ContestsController < ApplicationController
  # before_action :set_contest, only: [:show, :edit, :update, :destroy]

  # GET /contests
  # GET /contests.json
  def index
    if params[:latitude].nil? || params[:longitude].nil?
      render :json => { :error => 1, :success => 0 }
      return
    end

    @contests = Contests.get_open_contests(params)

    render json: @contests
  end

  def all
    @contests = Contests.get_contests
  end

  # GET /contests/1
  # GET /contests/1.json
  def show
    @submissions = Contests.get_contest_submissions(params[:id])
    unless @submissions.nil?
      render json: @submissions
      return
    end
  end

  def view
    @contest = Contests.get_contest(params[:id]).first
    @submissions = Submission.get_submissions_for_contest(params[:id])
  end

  # GET /contests/new
  def new
    @weather = ['rain','sun', 'overcast', 'fog', 'windy', 'snow','thunderstorm', 'hail']
  end

  # GET /contests/1/edit
  def edit
  end

  # POST /contests
  # POST /contests.json
  def create
    contest = contest_params[:contest]
    puts contest
    @contest = Contests.create(contest_params)
    respond_to do |format|
      unless @contest.nil?
        @contest[:createContest] = @contest["createContest"]
        format.html { redirect_to "/contests/view/#{@contest[:createContest]}" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /contests/1
  # PATCH/PUT /contests/1.json
  def update
    contestID = params[:id]
    submissionID = params[:contestID]
    res = Contests.set_winner(contestID, submissionID)
    # email using mailjet
    contest = Contests.get_contest(contestID).first
    test = "Congrats on winning the contest: #{contest["title"]}, You have won $#{contest["price"]}!"
    system("curl -X POST --user \"7c80d03e683e8c7313d50629a9feafb7:434aaee16cb9e82e6ff117fc2716c2c7\" https://api.mailjet.com/v3/send/message -F from='kelvin.ma23@gmail.com' -F to=james.gibbons@gmail.com -F subject='Congrats on winning!' -F text='#{test}'")
    redirect_to "/contests/view/#{contestID}"
  end

  # DELETE /contests/1
  # DELETE /contests/1.json
  def destroy
    @contest.destroy
    respond_to do |format|
      format.html { redirect_to contests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contest
      @contest = Contest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contest_params
      params
    end
end

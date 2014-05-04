class ContestsController < ApplicationController
  # before_action :set_contest, only: [:show, :edit, :update, :destroy]

  # GET /contests
  # GET /contests.json
  def index
    Mailer.test_email("TEST")
    if params[:latitude].nil? || params[:longitude].nil?
      render :json => { :error => 1, :success => 0 }
      return
    end

    @contests = Contests.get_open_contests(params)

    render json: @contests
  end

  # GET /contests/1
  # GET /contests/1.json
  def show
    @contest = Contests.get_contest(params[:id])
    unless @contest.nil?
      render json: @contest
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

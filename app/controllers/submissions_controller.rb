class SubmissionsController < ApplicationController
  # before_action :set_submission, only: [:show, :edit, :update, :destroy]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.get_submissions
    render json: @submissions
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @submission = Submission.get_submission(params[:id])
    unless @submission.nil?
      render json: @submission
    end
  end

  def me
    access_token = params[:access_token]
    user = User.find_from_token(access_token).first
    userID = user["id"]
    render json: Submission.get_my_submissions(userID)
  end
  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    submission = submission_params
    if submission[:userID].nil? || submission[:contestID].nil? || submission[:mediaURL].nil? || submission[:latitude].nil? || submission[:longitude].nil?
      return render :json => { :error => 1, :success => 0 }
    end

    @submission = Submission.create(submission)

    render json: @submission
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params
    end
end

class TimelinesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @milestones = @user.milestones.all
  end

  def show_overlay
    @milestone = Milestone.find(params[:milestone_id])
    # binding.pry
    puts 'triggered overlay!!!'
  end

  def contact
    @user = User.find(params[:user_id])
    @sender_email =  params[:message][:email]
    @message_body =  params[:message][:body]

    ContactMailer.contact_form_email(@user, @sender_email, @message_body).deliver_now
    @user.update(message_counter: @user.message_counter+1)
    puts @user.message_counter

  end

end

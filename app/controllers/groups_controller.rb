class GroupsController < ApplicationController
  # before_action :authenticate_user!
  def index
    # @groups = Group.all
    # @occasions = Occasion.all
    # this is the real:
    @occasions = current_user.occasions
  end

  def show
    @occasion = Occasion.find(params[:id])
  end

  def gift
    # p "TEST GIFT ADD MEMBER"

    @user_contact_ids = params["group_member"] ? params["group_member"]["user_contact_ids"] : []

    # @group_member = GroupMember.new
    # @group_member = GroupMember.find(params[:id])
    # @occasion = Occasion.find(params[:id])
    ## @group = Group.find(params[:id])
  end

  def confirmation
    # @group = Group.find(params[:id])
    @user_contact_ids = params["user_contact_ids"]
    # @photo
    # @budget

    # write all the code to save the group into the database.

    # user_contact_ids.each |user_contact_id| do
    #   GroupMember.create(user_contact_id: user_contact_id, occasion_id: occasion_id)
    # Group.new
    # raise
  end

  def new
    @contacts = current_user.contact
    @group_member = GroupMember.new
  end

  def create
    # @group = Group.new(group_params)
    # group_id = params[:group_id]
    # if @group.save
    # @occasion = Occasion.new
    #
    # @group_member = GroupMember.new(group_params)

    if @group_member.save
      puts "Group Member saved successfully!"
      redirect_to groups_gift_path, notice: 'Group member successfully added.'
    else
      puts "Errors: #{@group_member.errors}"
      # Handle validation errors, e.g., render the form again
      render :new
    end
    # @group = Group.new(group_params)

    # if @group.save
    #   redirect_to groups_gift_path, notice: 'Group member successfully added.'
    # else
    #   render :new_view
    # end

    # else

    # render :new
    # end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def group_params
    params.require(:group_member).permit(occasion_id: [], user_contact_id: [])

  end
end

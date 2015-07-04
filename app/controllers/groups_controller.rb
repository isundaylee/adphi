class GroupsController < ApplicationController
  load_and_authorize_resource

  def join
    brother = current_brother
    group = Group.find(params[:id])
    group.memberships.create(brother_id: brother.id)
  end

  def index
    @groups = Group.all.map do |g|
      {
        group: g,
        members: g.memberships.all.map do |m|
          Brother.find(m.brother_id).name
        end
      }
    end
  end

  def show
    group = Group.find(params[:id])
    @group = group
    @members = group.memberships.all.map do |m|
      Brother.find(m.brother_id).name
    end
  end

  def create
    name = params[:name]
    group = Group.create(name: name)
    redirect_to group_url(group), flash: {success: "You have successfully created the group #{name}. "}
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    @group = group
    respond_to do |format|
      format.js
    end
  end
end

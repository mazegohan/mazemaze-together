class UsersController < ApplicationController
# グループ作成関連  
  def group_index
    @group.all 
  end

  def shuffle_group
    @group.all
  end

  
# 社員関連
  def employee_index
    User.all
  end  

  def show
    User.find(params[:id])
  end 

  def new 
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)
    if @user.save!
      edirect_to users_path, notice: "ユーザー「#{@user.name}を登録しました」"
    else
      reder :new
    end
  end

  def update
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, notice:  "ユーザー「#{@user.name}を削除しました」"
  end

  private
  def user_params
    params.require(:tuser).permit(:id, :name, :pre_group_id, :group_id, :position_flg, :leader_flg)
  end
end

class UsersController < ApplicationController
  # 今月のグループ表示ロジック
  def group_index
    key_list = []
    name_list = []
    max_count = User.all.pluck(:pre_group_id).max
    max_count.times do |i|
      user = User.where(pre_group_id: i+1)
      key_list[i] = user.first.pre_group_id
      name_list[i] = user.map{|user| user.name}
    end
    # @group = {1=>["鵜殿", "小池", "勝又"], 2=>["渡邉", "吉貝", "澤田"]..etc}
    @group = [key_list, name_list].transpose.to_h
  end

  # グループ組み合わせロジック
  def shuffled_group
    @shuffled_group = User.all
  end

# 社員関連
  def employee_index
    User.all.order(id: "ASC")
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)
    if @user.save!
      redirect_to users_path, notice: "ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update!
      redirect_to users_path, notice: "ユーザー「#{@user.name}」の情報を更新しました"
    else
      render :update
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy!
      redirect_to admin_users_url, notice:  "ユーザー「#{@user.name}」を削除しました"
    else
      render :admin
    end
  end

  private
  def user_params
    params.require(:user).permit(:id, :name, :pre_group_id, :group_id, :position_flg, :leader_flg)
  end
end

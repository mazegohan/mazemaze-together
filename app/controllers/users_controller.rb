class UsersController < ApplicationController
# グループ作成関連
  def group_index
    pre_group_ids = []
    name_list = []

    group_count.times do |i|
      user = User.where(pre_group_id: i+1)
      pre_group_ids[i] = user.first.pre_group_id
      name_list[i] = user.map{|user| user.name}
    end
    # @pre_group = {1=>["鵜殿", "小池", "勝又"], 2=>["渡邉", "吉貝", "澤田"]..etc}
    @pre_group = [pre_group_ids, name_list].transpose.to_h
  end

  def shuffled_group
    member_ary = []
    leader_ary = []
    shuffled_group = []
    duplicate_group = []
    target_index = 0
    insert_target_index = 0

    # 先月のまぜご飯のリーダーを絞り込む
    leader_ary = User.where( leader_flg: 1 )

    # 先月のまぜご飯のメンバーを絞り込む
    member_ary = User.where( leader_flg: 0 )

    # メンバーをシャッフルして2人組に分ける処理
    shuffled_group = member_ary.to_a.shuffle!.each_slice(2).to_a

    # 2人組のメンバー配列に前回のまぜご飯リーダーを入れる
    leader_ary.to_a.shuffle!.each_with_index do |leader, i|
      shuffled_group[i] << leader
    end

    # 1人グループのindexを探す
    shuffled_group.each_with_index do |group, i|
      insert_target_index = i if group.count == 1
    end

    ## 1人グループを別グループに挿入
    shuffled_group[insert_target_index - 1] << shuffled_group[insert_target_index]

    ## 1人グループを削除
    shuffled_group.delete_at(insert_target_index)

    @shuffled_group = shuffled_group
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

  def group_count
    return User.all.pluck(:pre_group_id).max
  end

  private
  def user_params
    params.require(:user).permit(:id, :name, :pre_group_id, :group_id, :position_flg, :leader_flg)
  end
end

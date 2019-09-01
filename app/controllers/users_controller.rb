class UsersController < ApplicationController
# グループ作成関連
  def group_index
    key_list = []
    name_list = []

    group_count.times do |i|
      user = User.where(pre_group_id: i+1)
      key_list[i] = user.first.pre_group_id
      name_list[i] = user.map{|user| user.name}
    end
    # @pre_group = {1=>["鵜殿", "小池", "勝又"], 2=>["渡邉", "吉貝", "澤田"]..etc}
    @pre_group = [key_list, name_list].transpose.to_h
  end

  def shuffled_group
    member_ary = []
    leader_ary = []
    shuffled_group = []
    duplicate_group = []

    # 先月のまぜご飯のリーダーを絞り込む
    leader_ary = User.where( leader_flg: 1 )

    # 先月のまぜご飯のメンバーを絞り込む
    member_ary = User.where( leader_flg: 0 )

    # メンバーをシャッフルする処理
    member_ary.to_a.shuffle!.each_slice(2) do |member|
      duplicate_group << member if member.pluck(:pre_group_id)[0] == member.pluck(:pre_group_id)[1]
      shuffled_group << member
    end

    # 重複したメンバーをなくす処理
    duplicate_group.each_with_index do |group, i|
      break if group.blank?
      shuffled_group[i][0] = group[0] if shuffled_group[i][0].pre_group_id != group[0].pre_group_id
      shuffled_group << group
    end

    # メンバーの配列に前回のリーダーを入れる
    leader_ary.to_a.shuffle!.each_with_index do |leader, i|
      shuffled_group[i] << leader
    end

    # 最後にグループ内メンバーの重複をなくす
    shuffled_group.each_slice(3) do |group|
    end

    @post_group
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

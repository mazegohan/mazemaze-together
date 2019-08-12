class User < ApplicationRecord
  # id              primary
  # name            string
  # pre_group_id    integer
  # group_id        integer
  # position_id     integer # 役職
  # leader_flg      integer # まぜごはんのリーダー

  validates :name, presence: true
  validates :pre_group_id, presence: true
  validates :group_id, presence: true
  validates :position_id, presence: true
  validates :leader_flg, presence: true

end

User.create!(name: "鵜殿", pre_group_id: 1, group_id: 0, position_id: 0, leader_flg: 1)
User.create!(name: "小池", pre_group_id: 1, group_id: 0, position_id: 1, leader_flg: 0)
User.create!(name: "勝又", pre_group_id: 1, group_id: 0, position_id: 0, leader_flg: 0)
User.create!(name: "渡邉", pre_group_id: 2, group_id: 0, position_id: 0, leader_flg: 1)
User.create!(name: "吉貝", pre_group_id: 2, group_id: 0, position_id: 0, leader_flg: 0)
class User < ApplicationRecord
  # id              primary
  # name            string
  # pre_group_id    integer
  # group_id        integer
  # position_id     integer # 役職
  # leader_flg      integer # まぜごはんのリーダー

  validates :name, presence: true
  validates :position_id, presence: true
  validates :leader_flg, presence: true

end

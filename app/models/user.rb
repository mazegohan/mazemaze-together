class User < ApplicationRecord
  # id              primary
  # name            string
  # pre_group_id    integer
  # group_id        integer
  # position_id     integer
  # leader_flg      integer

  validates :name, presence: true
  validates :pre_group_id, presence: true
  validates :group_id, presence: true
  validates :position_id, presence: true
  validates :leader_flg, presence: true

end

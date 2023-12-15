class Board < ApplicationRecord
  validates :title, length: { maximum: 255 }, presence: true
  validates :body, length: { maximum: 65_535 }, presence: true
  attr_accessor :eastern_mode # 仮想属性としてeastern_modeを追加
end

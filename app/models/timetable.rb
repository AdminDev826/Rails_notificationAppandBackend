# == Schema Information
#
# Table name: timetables
#
#  id         :integer          not null, primary key
#  address_id :integer
#  day        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  start_at   :datetime
#  end_at     :datetime
#
# Indexes
#
#  index_timetables_on_address_id  (address_id)
#
# Foreign Keys
#
#  fk_rails_2a3c38b2e1  (address_id => addresses.id)
#

class Timetable < ApplicationRecord

  belongs_to :address

  extend TimeSplitter::Accessors
  split_accessor :start_at, :end_at

  scope :today, -> { where('timetables.day = ? or timetables.day = ? or timetables.day is null', I18n.t("date.day_names")[Time.now.wday], "") }
  scope :open, -> { where("timetables.start_at <= ? and timetables.end_at >= ?", Time.now, Time.now) }

  before_create :format_end_at

  private

  def format_end_at
    self.end_at += 1000.year
  end

end

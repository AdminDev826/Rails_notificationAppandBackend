# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  business_id :integer
#  day         :string
#  street      :string
#  zipcode     :string
#  city        :string
#  latitude    :float
#  longitude   :float
#  active      :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  start_time  :datetime
#  end_time    :datetime
#  name        :string
#  main        :boolean          default(FALSE), not null
#
# Indexes
#
#  index_addresses_on_business_id  (business_id)
#
# Foreign Keys
#
#  fk_rails_493c8e25df  (business_id => businesses.id)
#

class Address < ApplicationRecord
  belongs_to :business
  has_many :timetables, dependent: :destroy

  extend TimeSplitter::Accessors
  split_accessor :start_time, :end_time

  scope :active, -> { where(active: true) }
  scope :for_map_load, -> { where("(businesses.shop = ? and (day is null or day = ?)) or (businesses.itinerant = ? and addresses.active = ? and addresses.day = ?)", true, "", true, true, I18n.t("date.day_names")[Time.now.wday]) }
  scope :today, -> { where('addresses.active = ? and addresses.day = ?', true, I18n.t("date.day_names")[Time.now.wday]) }
  scope :in_time, -> { where("start_time.strftime('%R') <= ? and end_time.strftime('%R') >= ?", Time.now.strftime('%R'), Time.now.strftime('%R')) }
  scope :shop, -> { where('day is null or day = ?', "") }
  scope :main, -> { where(main: true) }

  validates :day, :inclusion=> { :in => I18n.t("date.day_names"), allow_blank: true }
  validate :day_uniqueness, if: :day_changed?

  validates :business_id, presence: true
  # validates :street, presence: true
  validates :zipcode, presence: true
  validates :city, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  before_save :controle_geocode!, if: :address_changed?

  def open?
    self.timetables.today.open.present? ? true : false
  end

  private

  def address_changed?
    street_changed? || zipcode_changed? || city_changed?
  end

  def address
    "#{street}, #{zipcode} #{city}"
  end

  def day_uniqueness
    if day.present? && business_id.present?
      errors.add(:day, "Ce jour est déjà créé !") if Address.where(day: self.day).where(business_id: self.business_id).count > 0
    end
  end

  def controle_geocode!
    while Address.where('id != ? and day = ? and latitude = ? and longitude = ?', self.id, self.day, latitude, longitude).count > 0
      self.latitude -= 0.0001
      self.longitude += 0.0001
    end
  end
end

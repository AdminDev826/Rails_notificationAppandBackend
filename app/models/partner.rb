# == Schema Information
#
# Table name: partners
#
#  id               :integer          not null, primary key
#  name             :string
#  email            :string
#  code_partner     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  nb_month         :integer          default(1)
#  times            :integer          default(0)
#  promo            :boolean          default(FALSE)
#  date_start_promo :date
#  date_end_promo   :date
#  user_id          :integer
#  exclusive        :boolean          default(FALSE), not null
#  shared           :boolean          default(FALSE), not null
#
# Indexes
#
#  index_partners_on_user_id  (user_id)
#

class Partner < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :code_partner, presence: true, uniqueness: true

  validate :control_code_partner, if: :code_partner_changed?

  def create_code_partner_business(name, email)
    self.name  = name
    self.email = email
    code = transco_code_partner(name)
    self.code_partner = code
    if self.save
      update_data_intercom_business
    end
  end

  def create_code_partner_user(user, code, exclusive, shared)
    self.name  = user.find_name_or_email?
    self.email = user.email
    self.code_partner = code
    self.promo = true
    self.user_id = user.id
    self.exclusive = exclusive
    self.shared = shared
    self.save
  end

  private

  def transco_code_partner(string)
    code = string.upcase.gsub(/[àâÀÂ]/,"A").gsub(/[éèêëÉÈÊË]/,"E").gsub(/[îïÎÏ]/,"I").gsub(/[ôöÔÖ]/,"O").gsub(/[ùûüÙÛÜ]/,"U").gsub(/[^a-zA-Z]/, '').strip
    i = 0
    while Partner.find_by_code_partner(code)
       code += i.to_s
       i += 1
    end
    return code
  end

  def control_code_partner
    if code_partner_changed? and code_partner_was.present?
      self.code_partner = transco_code_partner(self.code_partner)
    end
  end

  def update_data_intercom_business
    if code_partner_changed? and code_partner_was.present?
      # UPDATE CUSTOM ATTRIBUTES ON INTERCOM
      if @business = Business.find_by_email(self.email)
        intercom = Intercom::Client.new(app_id: ENV['INTERCOM_API_ID'], api_key: ENV['INTERCOM_API_KEY'])
        begin
          business = intercom.users.find(:user_id => 'B'+@business.id.to_s)
          business.custom_attributes["code_partner"] =  self.code_partner
          intercom.users.save(business)
        rescue Intercom::IntercomError => e
          puts e
        end
      end
    end
  end

end
